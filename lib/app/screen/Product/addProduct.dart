import 'package:flutter/material.dart';
import 'package:productstore/app/state/product_state.dart';
import 'package:productstore/app/viewModel/addProduct_viewModel.dart';
import 'package:productstore/app/widgets/button_widget.dart';
import 'package:productstore/app/widgets/inputText_widget.dart';
import 'package:provider/provider.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _productName = TextEditingController();
  TextEditingController _productSP = TextEditingController();
  TextEditingController _productCP = TextEditingController();
  TextEditingController _stock = TextEditingController();

  AddProductViewModel addProductViewModel = AddProductViewModel();

  void clearText() {
    _productName.clear();
    _productCP.clear();
    _productSP.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productState = Provider.of<ProductState>(context);
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // *  PRODUCT NAME
                inputTextWidget(
                  productName: _productName,
                  labelText: "Product Name",
                  hintText: "Product Name",
                  maxLength: 255,
                  maxLines: 5,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Invalid";
                    } else {
                      print(value);
                    }
                  },
                ),

                // * SELLING PRICE
                inputTextWidget(
                  productName: _productSP,
                  labelText: "Product Selling price",
                  hintText: "MRP",
                  maxLength: 255,
                  keyboardType: TextInputType.numberWithOptions(),
                  maxLines: 1,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Invalid";
                    } else {
                      print(value);
                    }
                  },
                ),

                // * COST PRICE
                inputTextWidget(
                  productName: _productCP,
                  labelText: "Product Cost Price",
                  hintText: "Cost Price",
                  maxLength: 255,
                  keyboardType: TextInputType.numberWithOptions(),
                  maxLines: 1,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Invalid";
                    } else {
                      print(value);
                    }
                  },
                ),

                // * STOCK
                inputTextWidget(
                  productName: _stock,
                  labelText: "Stock",
                  hintText: "Stock",
                  maxLength: 255,
                  keyboardType: TextInputType.numberWithOptions(),
                  maxLines: 1,
                  validator: (String value) {
                    if (value.isEmpty) {
                      return "Invalid";
                    } else {
                      print(value);
                    }
                  },
                ),

                // * SAVE BUTTON
                customButton(
                  () {
                    if (_key.currentState.validate()) {
                      productState.addProduct(
                          _productName.text,
                          int.parse(_productCP.text),
                          int.parse(_productSP.text),
                          int.parse(_stock.text));
                      addProductViewModel.addProduct(
                        productName: _productName.text,
                        productCP: int.parse(_productCP.text),
                        productSP: int.parse(_productSP.text),
                        stock: int.parse(_stock.text),
                      );
                      clearText();
                    }
                  },
                  "Save",
                  Colors.green,
                  size,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
