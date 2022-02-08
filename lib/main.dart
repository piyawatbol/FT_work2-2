// ignore_for_file: unused_import, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:work2_2/provider/transaction_provider.dart';
import 'package:work2_2/screen/form_screen.dart';
import 'package:work2_2/screen/home_screen.dart';
import 'package:work2_2/screen/settings_page.dart';
import 'models/Transactions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.red,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MyHomePage(title: 'แอพบัญชี'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.red,
        body: TabBarView(
          children: [const HomeScreen(), FormScreen(), SettingPage()],
        ),
        bottomNavigationBar: const TabBar(
          tabs: [
            Tab(
              icon: Icon(Icons.list),
              text: "รายการธุรกรรม",
            ),
            Tab(icon: Icon(Icons.add), text: "เพิ่มข้อมูล"),
            Tab(icon: Icon(Icons.settings), text: 'Setting')
          ],
        ),
      ),
    );
  }
}
