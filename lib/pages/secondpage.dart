import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tajriba_networkrespons/pages/homepage.dart';
import 'package:tajriba_networkrespons/services/networkservices.dart';

class SecondPage extends StatefulWidget {
  static final String id = "SecondPage";

 final bool tek;
 final String putId;
  SecondPage(this.tek,this.putId);


  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final titlecontroller = TextEditingController();
  final parentcontroller = TextEditingController();

  _islogin() async {
    String title = titlecontroller.text.toString().trim();
    String parentId = parentcontroller.text.toString().trim();
        var mal;
     if(widget.tek){
       var malumot = await Network.POST(
        Network.api_post, Network.createparams(title, parentId));
     mal = jsonDecode(malumot);
     }else{
       var malumot = await Network.PUT(
        Network.api_put,widget.putId, Network.createparams(title, parentId));
     mal = jsonDecode(malumot);
     }

    Fluttertoast.showToast(
        msg: mal['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);

    titlecontroller.clear();
    parentcontroller.clear();

    Navigator.pushReplacementNamed(context, HomePage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.white,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                    controller: titlecontroller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "title",
                      labelStyle: TextStyle(fontSize: 23),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      )),
                    )),
                SizedBox(
                  height: 25,
                ),
                TextField(
                    controller: parentcontroller,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "parent id",
                      labelStyle: TextStyle(fontSize: 23),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      )),
                    )),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    _islogin();
                  },
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        "Saqlash",
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
