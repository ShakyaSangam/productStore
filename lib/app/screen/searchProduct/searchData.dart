import 'package:flutter/material.dart';
import 'package:productstore/app/model/product.dart';

class SearchData extends SearchDelegate {
  final List<Product> productList;
  SearchData({this.productList});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: Icon(Icons.cancel_presentation),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.of(context).pop(),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text("$query");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionsList = query.isEmpty
        ? productList
        : productList
            .where((product) => product.productName.startsWith(query))
            .toList();
    return ListView.builder(
      itemCount: suggestionsList.length,
      itemBuilder: (ctx, index) {
        return ListTile(
          onTap: () {},
          leading: Text("Stock: " + suggestionsList[index].stock.toString()),
          trailing: Text("MRP: " + suggestionsList[index].productSP.toString()),
          subtitle: Text(
              "Cost price: " + suggestionsList[index].productCP.toString()),
          title: Text(suggestionsList[index].productName),
        );
      },
    );
  }
}
