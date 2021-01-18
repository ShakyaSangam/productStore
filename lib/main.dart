import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/screen/initialScreen.dart';
import 'app/state/product_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductState>(
          create: (_) => ProductState(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: InitialScreen(),
      ),
    );
  }
}
