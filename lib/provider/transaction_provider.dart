import 'package:flutter/foundation.dart';
import 'package:work2_2/database/transaction_db.dart';
import 'package:work2_2/models/transactions.dart';

class TransactionProvider with ChangeNotifier {
  // ตัวอย่างข้อมูล
  List<Transactions> transactions = [];

  // ดึงข้อมูล
  List<Transactions> getTransaction() {
    return transactions;
  }

  void initData() async {
    var db = TransactionDB(dbName: "transactions.db");
    //ดึงข้อมูลมาแสดงผล
    transactions = await db.loadAllData();
    notifyListeners();
  }

  void addTransaction(Transactions statement) async {
    var db = TransactionDB(dbName: "transactions.db");
    //บันทึกข้อมูล
    await db.InsertData(statement);
    //ดึงข้อมูลมาแสดงผล
    transactions = await db.loadAllData();
    notifyListeners(); //แจ้งเตือน Consumer
  }

  void clearAllPost() async {
    var postDB = TransactionDB(dbName: 'transactions.db');
    await postDB.clearPostData();

    transactions = [];

    notifyListeners();
  }
}
