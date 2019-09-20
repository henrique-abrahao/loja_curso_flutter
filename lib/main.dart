import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:loja/models/user_model.dart';
import 'package:loja/screens/home_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    FlutterStatusbarcolor.setStatusBarColor(Colors.transparent);
    FlutterStatusbarcolor.setNavigationBarColor(Colors.black12, animate: true);
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: "Flutter's Cloat",
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Color.fromARGB(255, 4, 125, 141)
        ),
        home: HomeScreen(),
      ),
    );
  }
}
