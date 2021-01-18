import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:productstore/app/model/product.dart';
import 'package:productstore/app/repo/repository.dart';

class ProductState extends ChangeNotifier {
  Repository repository = Repository();

  List<Product> productList = [];

  Future fetchProduct() async {
    List<DocumentSnapshot> list = await repository.fetchProduct();
productList.clear();
    for (int i = 0; i < list.length; i++) {
      Product product = Product.fromMap(list[i].data);
      productList.add(product);
    }
    print("product list: ${productList.length}");
    notifyListeners();
  }

  addProduct(String name, int cp, int sp, int stock) {
    Map<String, dynamic> data = {};
    data["productName"] = name;
    data["productSP"] = sp;
    data["productCP"] = cp;
    data["stock"] = stock;
    Product product = Product.fromMap(data);
    productList.add(product);
    print("product list: ${productList.length}");

    notifyListeners();
  }

  ProductState() {
    fetchProduct();
  }
}
