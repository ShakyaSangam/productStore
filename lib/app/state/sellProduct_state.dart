import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:productstore/app/model/product.dart';
import 'package:productstore/app/model/sellProduct.dart';

class SellProductState extends ChangeNotifier {
  List<SellProductMoel> productList = [];

  sellproduct({Product products, int soldPrice, int qty}) {
    SellProductMoel sellProduct = SellProductMoel(
        products: products,
        soldPrice: soldPrice,
        qty: qty,
        dateTime: DateTime.now());

    productList.add(sellProduct);
    notifyListeners();
  }

  deleteProduct(SellProductMoel sellProduct) {
    productList.removeWhere(
      (sellProductMoel) =>
          sellProductMoel.products.productName ==
              sellProduct.products.productName &&
          sellProductMoel.dateTime == sellProduct.dateTime,
    );
    notifyListeners();
  }

  clearCart() {
    productList.clear();
    notifyListeners();
  }
}
