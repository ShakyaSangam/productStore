import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:productstore/app/state/sellProduct_state.dart';

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
    Firestore.instance
        .collection("products")
        .document(docID)
        .updateData({"$fieldName": value});
  }

  void billCheckOut({
    SellProductState sellProductState,
    int total,
    String buyerName,
    double discount,
  }) async {
    DocumentReference documentReference =
        Firestore.instance.collection("sells").document();
    Firestore.instance
        .collection("sells")
        .document(documentReference.documentID)
        .setData({
      "buyerName": buyerName,
      "total": total,
      "discoutAmount": discount,
      "timeStamp": FieldValue.serverTimestamp()
    });

    for (int i = 0; i < sellProductState.productList.length; i++) {
      Firestore.instance
          .collection("sells")
          .document(documentReference.documentID)
          .collection("products")
          .add({
        "productName": sellProductState.productList[i].products.productName,
        "productCP": sellProductState.productList[i].products.productCP,
        "productSP": sellProductState.productList[i].products.productSP,
        "qty": sellProductState.productList[i].qty,
      });
    }
  }
}
