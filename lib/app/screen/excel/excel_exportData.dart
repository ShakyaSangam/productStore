// import 'dart:html';
// import 'dart:io';

// import 'package:csv/csv.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:simple_permissions/simple_permissions.dart';

// /// Convert a map list to csv
// String mapListToCsv(List<Map<String, dynamic>> mapList,
//     {ListToCsvConverter converter}) {
//   if (mapList == null) {
//     return null;
//   }
//   converter ??= const ListToCsvConverter();
//   var data = <List>[];
//   var keys = <String>[];
//   var keyIndexMap = <String, int>{};

//   // Add the key and fix previous records
//   int _addKey(String key) {
//     var index = keys.length;
//     keyIndexMap[key] = index;
//     keys.add(key);
//     for (var dataRow in data) {
//       dataRow.add(null);
//     }
//     return index;
//   }

//   for (var map in mapList) {
//     // This list might grow if a new key is found
//     var dataRow = List(keyIndexMap.length);
//     // Fix missing key
//     map.forEach((key, value) {
//       var keyIndex = keyIndexMap[key];
//       if (keyIndex == null) {
//         // New key is found
//         // Add it and fix previous data
//         keyIndex = _addKey(key);
//         // grow our list
//         dataRow = List.from(dataRow, growable: true)..add(value);
//       } else {
//         dataRow[keyIndex] = value;
//       }
//     });
//     data.add(dataRow);
//   }
//   return converter.convert(<List>[]
//     ..add(keys)
//     ..addAll(data));
// }

// class ExcelDataTry {
//   String name;
//   String gender;
//   String age;

//   ExcelDataTry({this.age, this.gender, this.name});
// }

// getCsv() async {
//   //create an element rows of type list of list. All the above data set are stored in associate list
// //Let associate be a model class with attributes name,gender and age and associateList be a list of associate model class.
//   List<ExcelDataTry> associateList = [
//     ExcelDataTry(name: "sangam", age: "12", gender: "male"),
//     ExcelDataTry(name: "sangam", age: "12", gender: "male"),
//   ];
//   var file;
//   List<List<dynamic>> rows = List<List<dynamic>>();
//   for (int i = 0; i < associateList.length; i++) {
// //row refer to each column of a row in csv file and rows refer to each row in a file
//     List<dynamic> row = List();
//     row.add(associateList[i].name);
//     row.add(associateList[i].gender);
//     row.add(associateList[i].age);
//     rows.add(row);
//   }

//   if(Permission.WriteExternalStorage){}

//   await SimplePermissions.requestPermission(Permission.WriteExternalStorage);
//   bool checkPermission =
//       await SimplePermissions.checkPermission(Permission.WriteExternalStorage);
//   if (checkPermission) {
// //store file in documents folder

//     String dir =
//         (await getExternalStorageDirectory()).absolute.path + "/documents";
//     file = "$dir";
//     print(" FILE " + file);
//     File f = new File(file + "filename.csv");

// // convert rows to String and write as csv file

//     String csv = const ListToCsvConverter().convert(rows);
//     f.writeAsString(csv);
//   }
// }
