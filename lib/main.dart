import 'package:flutter/material.dart';
import 'package:tajriba_networkrespons/pages/homepage.dart';
import 'package:tajriba_networkrespons/pages/secondpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        HomePage.id: (context)=>HomePage(),
        
      },
    );
  }
}

