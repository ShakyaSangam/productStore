import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:productstore/app/model/product.dart';
import 'package:productstore/app/model/sellProduct.dart';
import 'package:productstore/app/repo/repository.dart';
import 'package:productstore/app/state/product_state.dart';
import 'package:productstore/app/state/sellProduct_state.dart';
import 'package:productstore/app/widgets/button_widget.dart';
import 'package:productstore/app/widgets/inputText_widget.dart';
import 'package:provider/provider.dart';

class SellProduct extends StatefulWidget {
  @override
  _SellProductState createState() => _SellProductState();
}

class _SellProductState extends State<SellProduct> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  GlobalKey<FormState> _key2 = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _controller = TextEditingController();
  TextEditingController _buyerName = TextEditingController();

  String selectedValue;
  String qty = "1";

  Repository _repository = Repository();

  @override
  void initState() {
    super.initState();
    _controller.text = "1";
  }

  Iterable<Product> fetchCost(String productName, ProductState productState) {
    Iterable<Product> product = productState.productList
        .where((product) => product.productName == productName);
    return product;
  }

  @override
  Widget build(BuildContext context) {
    final productState = Provider.of<ProductState>(context);
    final sellProductState = Provider.of<SellProductState>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.list_rounded),
            onPressed: () {
              _scaffoldKey.currentState.openEndDrawer();
            },
          )
        ],
      ),
      endDrawer: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: buildDataTable(sellProductState, size, context),
              ),
            ),
          ],
        ),
      ),
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            children: [
              DropdownButton<String>(
                hint: Text("Choose product"),
                value: selectedValue,
                items: productState.productList.map((e) {
                  return DropdownMenuItem(
                    value: e.productName,
                    child: Text(e.productName),
                  );
                }).toList(),
                onChanged: (String value) {
                  setState(() {
                    selectedValue = value;
                  });
                },
              ),
              inputTextWidget(
                productName: _controller,
                labelText: "price",
                hintText: "price",
                maxLength: 255,
                onFieldSubmitted: (String value) {
                  print(value);
                  if (value != "") {
                    setState(() {
                      qty = value ?? "1";
                    });
                  }
                },
                maxLines: 1,
                keyboardType: TextInputType.number,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Invalid";
                  } else {
                    print(value);
                  }
                },
              ),
              if (selectedValue != null) ...[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(color: Colors.grey.shade300),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Text("Name: " +
                                fetchCost(selectedValue, productState)
                                    .first
                                    .productName),
                          ),
                          ListTile(
                            title: Text("Selling Price: RS." +
                                fetchCost(selectedValue, productState)
                                    .first
                                    .productSP
                                    .toString()),
                            subtitle: Text("Qty: $qty"),
                          ),
                          Container(
                            alignment: Alignment.bottomRight,
                            child: Text(
                                "Total:  ${int.parse(qty) * fetchCost(selectedValue, productState).first.productSP}"),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                customButton(
                  () {
                    if (_key.currentState.validate()) {
                      if (qty != _controller.text) {
                        setState(() {
                          qty = _controller.text;
                        });
                      }
                      sellProductState.sellproduct(
                        products: fetchCost(selectedValue, productState).first,
                        soldPrice: int.parse(qty) *
                            fetchCost(selectedValue, productState)
                                .first
                                .productSP,
                        qty: int.parse(qty),
                      );
                    }
                  },
                  "Add to cart",
                  Colors.green,
                  size,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  customDialog(Size size, Function onTap) async {
    return showDialog(
      context: context,
      child: AlertDialog(
        title: Text("Buyer Name"),
        content: Form(
          key: _key2,
          child: inputTextWidget(
            productName: _buyerName,
            labelText: "Buyer Name",
            hintText: "Name",
            maxLength: 255,
            keyboardType: TextInputType.text,
            maxLines: 1,
            validator: (String value) {
              if (value.isEmpty) {
                return "Invalid";
              } else {
                print(value);
              }
            },
          ),
        ),
        actions: [
          customButton(
            onTap,
            "Update",
            Colors.green,
            size,
          ),
        ],
      ),
    );
  }

  DataTable buildDataTable(
      SellProductState sellProductState, Size size, BuildContext context) {
    int total = sellProductState.productList.fold<int>(
        0, (previousValue, element) => element.soldPrice + previousValue);
    return DataTable(
      // showCheckboxColumn: t
      rows: sellProductState.productList.map((e) {
        return buildDataRow(e, size, context, sellProductState);
      }).toList(),
      columns: <DataColumn>[
        DataColumn(
          label: Row(
            children: [
              Text("Total: $total"),
              SizedBox(
                width: 2,
              ),
              MaterialButton(
                color: Colors.green,
                onPressed: () => customDialog(
                  size,
                  () {
                    if (_key2.currentState.validate()) {
                      _repository.billCheckOut(
                        sellProductState: sellProductState,
                        total: total,
                        buyerName: _buyerName.text,
                      );
                      sellProductState.clearCart();
                      _buyerName.clear();
                      Navigator.of(context).pop();
                    }
                  },
                ),
                child: Text("Sell", style: TextStyle(color: Colors.white),),
              )
            ],
          ),
        ),
        DataColumn(
          label: Text("Product Name"),
        ),
        DataColumn(
          label: Text("QTY"),
        ),
        DataColumn(
          label: Text("Price"),
        ),
      ],
    );
  }

  DataRow buildDataRow(SellProductMoel e, Size size, BuildContext context,
      SellProductState sellProductState) {
    // bool selectRow = false;
    return DataRow(
      // selected: selectRow,
      // onSelectChanged: (value) {
      //   setState(() {
      //     selectRow = value;
      //   });
      //   print(value);
      // },
      cells: <DataCell>[
        DataCell(
          IconButton(
            onPressed: () => sellProductState.deleteProduct(e),
            icon: Icon(
              Icons.delete,
              color: Colors.redAccent,
            ),
          ),
        ),
        DataCell(
          Text(e.products.productName),
        ),
        DataCell(
          Text(e.qty.toString()),
        ),
        DataCell(
          Text(e.soldPrice.toString()),
        ),
      ],
    );
  }
}
