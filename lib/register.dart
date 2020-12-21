import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './api.dart';
import 'dart:convert';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _Nama = TextEditingController();
  TextEditingController _No_Telp_Hp = TextEditingController();
  TextEditingController _Email = TextEditingController();
  TextEditingController _Username = TextEditingController();
  TextEditingController _Password = TextEditingController();

  String baseUrl = Api.regis;

  String msg = "";

  insertApi() async {
    final res = await http.post(baseUrl, body: {
      'Nama': _Nama.text,
      'No_Telp_Hp': _No_Telp_Hp.text,
      'Email': _Email.text,
      'Username': _Username.text,
      'Password': _Password.text
    });

    final dataJson = jsonDecode(res.body);

    _Nama.clear();
    _No_Telp_Hp.clear();
    _Email.clear();
    _Username.clear();
    _Password.clear();

    if (dataJson['status'] == 1) {
      print(dataJson['msg']);
      showDialog(
          context: context,
          builder: (c) {
            return AlertDialog(
              title: Text("Notifikasi"),
              content: Text(dataJson['msg']),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Close"),
                )
              ],
            );
          });
      setState(() {
        msg = dataJson['msg'];
      });
    } else if (dataJson['status'] == 2) {
      print(dataJson['msg']);
      Navigator.of(context).pop();
      setState(() {
        msg = "";
      });
    } else {
      print(dataJson['msg']);
      setState(() {
        msg = dataJson['msg'];
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        child: Center(
          child: ListView(
            children: <Widget>[

              // TextField Nama
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    gradient:
                    LinearGradient(colors: [Colors.lightBlueAccent, Colors.blueAccent]),
                    borderRadius: BorderRadius.circular(20.0)),
                child: TextFormField(
                  controller: _Nama,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Nama",
                      hintText: "Nama"),
                  textInputAction: TextInputAction.next
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              // TextField Nomor Telpom
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    gradient:
                    LinearGradient(colors: [Colors.lightBlueAccent, Colors.blueAccent]),
                    borderRadius: BorderRadius.circular(20.0)),
                child: TextField(
                  controller: _No_Telp_Hp,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Nomor Telpon",
                      hintText: "Nomor Telpon"),
                  textInputAction: TextInputAction.next,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              // TextField Email
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    gradient:
                    LinearGradient(colors: [Colors.lightBlueAccent, Colors.blueAccent]),
                    borderRadius: BorderRadius.circular(20.0)),
                child: TextField(
                  controller: _Email,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "E-Mail",
                      hintText: "E-Mail"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              // TextField Username
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    gradient:
                    LinearGradient(colors: [Colors.lightBlueAccent, Colors.blueAccent]),
                    borderRadius: BorderRadius.circular(20.0)),
                child: TextField(
                  controller: _Username,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Username",
                      hintText: "Username"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              //TextField Password
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    gradient:
                    LinearGradient(colors: [Colors.lightBlueAccent, Colors.blueAccent]),
                    borderRadius: BorderRadius.circular(20.0)),
                child: TextField(
                  controller: _Password,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "Password",
                      hintText: "Password"),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),

              Material(
                borderRadius: BorderRadius.circular(20.0),
                elevation: 10.0,
                color: Colors.blueAccent,
                child: MaterialButton(
                  onPressed: () {
                    insertApi();
                  },
                  color: Colors.blueAccent,
                  child: Text("REGISTER"),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(msg, style: TextStyle(color: Colors.blueAccent)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
