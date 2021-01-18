import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String productName;
  int productSP;
  int productCP;
  int stock;

  Product({
    this.productCP,
    this.productName,
    this.productSP,
    this.stock,
  });

  Map<String, dynamic> toMap(
      {String productName, int productSP, int productCP, int stock}) {
    Map<String, dynamic> data = {};
    data["productName"] = productName;
    data["productSP"] = productSP;
    data["productCP"] = productCP;
    data["stock"] = stock;
    data["timestamp"] = FieldValue.serverTimestamp();

    return data;
  }

  Product.fromMap(Map<String, dynamic> mapData) {
    this.productName = mapData["productName"];
    this.productSP = mapData["productSP"];
    this.productCP = mapData["productCP"];
    this.stock = mapData["stock"];
  }
}
