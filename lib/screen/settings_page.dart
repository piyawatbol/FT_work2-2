// ignore_for_file: deprecated_member_use, unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:work2_2/models/transactions.dart';
import 'package:work2_2/provider/transaction_provider.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: RaisedButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Do you have to delete it?"),
                    content: Text("delete all data"),
                    actions: [
                      FlatButton(
                          onPressed: () {
                            Provider.of<TransactionProvider>(context, listen: false)
                                .clearAllPost(); 
                            Navigator.pop(context); 
                          },
                          child: Text("ok")),
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context); // ทำการย้อนกลับ
                        },
                        child: Text("cancel"),
                      ),
                    ],
                  );
                });
          },
          child: Text('delete all data'),
        ),
      ),
    );
  }
}
