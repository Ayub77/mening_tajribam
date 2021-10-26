import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tajriba_networkrespons/pages/secondpage.dart';
import 'package:tajriba_networkrespons/services/networkservices.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static final String id = "HomePage";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool setaktiv = true;
  Future _openPage(bool tek, String id) async {
    Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new SecondPage(tek, id);
    }));
  }

  Future _loadingData() async {
    var row = await apiPostList();
    var data = jsonDecode(row)['data'];
    return Future.value(data);
  }

  apiPostList() async {
    try {
      return await Network.GET(Network.api_get, Network.emptyparams());
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "malumotlar",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: _loadingData(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return _buildrow(snapshot.data);
          } else {
            return Center(
              child: Text("server bilan aloqa yo'q"),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openPage(true, "");
        },
        tooltip: 'incremat',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildrow(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 94,
            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.green[400]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data[index]['title'],
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        _openPage(false, data[index]['id'].toString());
                      },
                      icon: Icon(Icons.change_circle_outlined),
                      color: Colors.white70,
                      iconSize: 20,
                    ),
                    IconButton(
                      onPressed: () {
                        _delete(data[index]['id'].toString());
                      },
                      icon: Icon(Icons.delete),
                      color: Colors.white60,
                      iconSize: 20,
                    ),
                    
                  ],
                )
              ],
            ),
          );
        });
  }

  _delete(String id) async {
    var malumot =
        await Network.DELETE(Network.api_delete, id, Network.emptyparams());

    var mal = jsonDecode(malumot);
    Fluttertoast.showToast(
        msg: mal['message'],
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
    setState(() {
      _loadingData();
    });
  }
}
