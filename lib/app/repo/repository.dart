import 'package:cloud_firestore/cloud_firestore.dart';

class Repository {

  Future addProduct({Map<String, dynamic> data}) async {
    Firestore.instance.collection("products").document().setData(data);
  }

  Future<List<DocumentSnapshot>> fetchProduct() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("products").getDocuments();

    return querySnapshot.documents;
  }

  void updateProduct({String fieldName, String docID, dynamic value}) {
    Firestore.instance.collection("products").document(docID).updateData({
      "$fieldName": value
    });
  }
}
