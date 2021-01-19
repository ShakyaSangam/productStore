import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productstore/app/model/product.dart';

class SellProductMoel {
  Product products;
  int soldPrice;
  int qty;
  DateTime dateTime;

  SellProductMoel({
    this.products,
    this.soldPrice,
    this.qty,
    this.dateTime
  });
}
