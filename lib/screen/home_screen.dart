// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:work2_2/models/transactions.dart';
import 'package:work2_2/provider/transaction_provider.dart';
import 'form_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    @override
  void initState() {
    
    super.initState();
    Provider.of<TransactionProvider>(context,listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
        appBar: AppBar(
          title: const Text("แอพบัญชี"),
          actions: [
            IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () {
                    SystemNavigator.pop();
                })
          ],
        ),
        body: Consumer(
          builder: (context, TransactionProvider provider,child) {
            var count = provider.transactions.length; //นับจำนวนข้อมูล
            if (count <= 0) {
              return const Center(
                child: Text(
                  "ไม่พบข้อมูล",
                  style: TextStyle(fontSize: 35),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: count,
                  itemBuilder: (context, int index) {
                    Transactions data = provider.transactions[index];
                    return Card(
                      elevation: 5,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: FittedBox(
                            child: Text(data.amount.toString()),
                          ),
                        ),
                        title: Text(data.title),
                        subtitle: Text(DateFormat("dd/MM/yyyy").format(data.date)),
                      ),
                    );
                  });
            }
          },
        ));
  }
}