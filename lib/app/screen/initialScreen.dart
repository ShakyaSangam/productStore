import 'package:flutter/material.dart';
import 'package:productstore/app/screen/searchProduct/searchData.dart';
import 'package:productstore/app/state/product_state.dart';
import 'package:productstore/app/widgets/button_widget.dart';
import 'package:provider/provider.dart';

import 'Product/addProduct.dart';
import 'Product/fetchData.dart';
import 'Product/sellProduct.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  Future<void> onRefresh(ProductState productState) async {
    Future.delayed(
      Duration(seconds: 2),
      () {
        return productState.fetchProduct();
      },
    );
    // productState.fetchProduct();
  }

  @override
  Widget build(BuildContext context) {
    final productState = Provider.of<ProductState>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: RefreshIndicator(
        onRefresh: () => onRefresh(productState),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  customButton(
                    () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SellProduct())),
                    "Sell Product",
                    Colors.yellow,
                    size,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customButton(
                    () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddProduct())),
                    "create",
                    Colors.green,
                    size,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  customButton(
                    () => showSearch(
                      context: context,
                      delegate: SearchData(
                        productList: productState.productList,
                      ),
                    ),
                    "Search",
                    Colors.yellow,
                    size,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customButton(
                    () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => FetchData())),
                    "Data",
                    Colors.yellow,
                    size,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
