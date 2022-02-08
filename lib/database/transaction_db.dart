// ignore_for_file: deprecated_member_use, non_constant_identifier_names, unnecessary_this

import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';
import 'package:work2_2/models/transactions.dart';

class TransactionDB {
  //บริการเกียวกับฐานข้อมูล

  String dbName; //เก็บชื่อฐานข้อมูล

  // ถ้ายังไม่ถูกสร้าง => สร้าง
  // ถูกสร้างไว้แล้ว => เปิด
  TransactionDB({required this.dbName});

  Future<Database> openDatabase() async {
    //หาตำแหน่งที่จะเก็บข้อมูล
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbLocation = join(appDirectory.path, dbName);
    // สร้าง database
    DatabaseFactory dbFactory = databaseFactoryIo;
    Database db = await dbFactory.openDatabase(dbLocation);
    return db;
  }

  //บันทึกข้อมูล
  Future<int> InsertData(Transactions statement) async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store("expense");

    // json
    var keyID = store.add(db, {
      "title": statement.title,
      "amount": statement.amount,
      "date": statement.date.toIso8601String()
    });
    db.close();
    return keyID;
  }

  //ดึงข้อมูล
  Future<List<Transactions>> loadAllData() async {
    var db = await openDatabase();
    var store = intMapStoreFactory.store("expense");
    var snapshot = await store.find(db,
        finder: Finder(sortOrders: [
          SortOrder(Field.key, false)
        ])); //false เรียงลำดับข้อมูลจากใหม่ไปเก่า
    var transactionList = <Transactions>[];
    //ดึงมาทีละแถว
    for (var record in snapshot) {
      transactionList.add(Transactions(
          title: record["title"] as String,
          amount: record["amount"] as double,
          date: DateTime.parse(record["date"] as String)));
    }
    return transactionList;
  }

  Future<void> clearPostData() async {
    var db = await this.openDatabase();
    var store = intMapStoreFactory.store('expense');
    await store.drop(db);
  }
}
