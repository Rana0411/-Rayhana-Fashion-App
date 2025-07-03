import 'package:fashion_app/helper/router.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(onGenerateRoute: generateRoute, debugShowCheckedModeBanner: false,);
  }
}
