import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:productstore/app/repo/repository.dart';
import 'package:productstore/app/widgets/button_widget.dart';
import 'package:productstore/app/widgets/inputText_widget.dart';

class FetchData extends StatefulWidget {
  @override
  _FetchDataState createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  Repository _repository = Repository();
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();

  customDialog(
      DocumentSnapshot e, Size size, String label, Function onTap) async {
    return showDialog(
      context: context,
      child: AlertDialog(
        title: Text("Update data"),
        content: Form(
          key: _key,
          child: inputTextWidget(
            productName: _controller,
            labelText: "Product Name",
            hintText: "Cost Price",
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder(
        stream: Firestore.instance.collection("products").snapshots(),
        builder: (ctx, snap) {
          if (snap.hasData) {
            List<DocumentSnapshot> _doc = snap.data.documents;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                rows: _doc.map((e) {
                  return DataRow(cells: <DataCell>[
                    DataCell(
                      Text(e.data["productName"]),
                      onTap: () {
                        setState(() {
                          _controller.text = e.data["productName"];
                        });
                        customDialog(e, size, "productName", () {
                          if (_key.currentState.validate()) {
                            _repository.updateProduct(
                                fieldName: "productName",
                                docID: e.documentID,
                                value: _controller.text);
                            _controller.clear();
                            Navigator.of(context).pop();
                          }
                        });
                      },
                    ),
                    DataCell(
                      Text(e.data["productSP"].toString()),
                      onTap: () {
                        setState(() {
                          _controller.text = e.data["productSP"].toString();
                        });
                        customDialog(e, size, "productSP", () {
                          if (_key.currentState.validate()) {
                            _repository.updateProduct(
                                fieldName: "productSP",
                                docID: e.documentID,
                                value: int.parse(_controller.text));
                            _controller.clear();
                            Navigator.of(context).pop();
                          }
                        });
                      },
                    ),
                    DataCell(
                      Text(e.data["productCP"].toString()),
                      onTap: () {
                        setState(() {
                          _controller.text = e.data["productCP"].toString();
                        });
                        customDialog(e, size, "productCP", () {
                          if (_key.currentState.validate()) {
                            _repository.updateProduct(
                                fieldName: "productCP",
                                docID: e.documentID,
                                value: int.parse(_controller.text));
                            _controller.clear();
                            Navigator.of(context).pop();
                          }
                        });
                      },
                    ),
                    DataCell(
                      Text(e.data["stock"].toString()),
                      onTap: () {
                        setState(() {
                          _controller.text = e.data["stock"].toString();
                        });
                        customDialog(e, size, "stock", () {
                          if (_key.currentState.validate()) {
                            _repository.updateProduct(
                                fieldName: "stock",
                                docID: e.documentID,
                                value: int.parse(_controller.text));
                            _controller.clear();
                            Navigator.of(context).pop();
                          }
                        });
                      },
                    ),
                  ]);
                }).toList(),
                columns: <DataColumn>[
                  DataColumn(
                    label: Text("Name"),
                  ),
                  DataColumn(
                    label: Text("MRP"),
                  ),
                  DataColumn(
                    label: Text("C.P"),
                  ),
                  DataColumn(
                    label: Text("Stock"),
                  ),
                ],
              ),
            );
          } else {
            return LinearProgressIndicator();
          }
        },
      ),
    );
  }
}
