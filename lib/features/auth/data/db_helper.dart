import 'dart:io';
import 'package:expenso_app/core/constant/app_constants.dart';
import 'package:expenso_app/features/auth/model/user_model.dart';
import 'package:expenso_app/features/presentation/model/expenso_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';


class DBHelper{
  DBHelper._();
  static DBHelper getInstance()=> DBHelper._();

  Database? mDB;

  Future<Database> initDB() async {
    mDB ??= await openDB();
    return mDB!;
  }

  Future<Database> openDB() async {
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String dbPath =join(appDocDir.path,AppConstant.dbName);
    return await openDatabase(dbPath,version: 1,onCreate: (db,version){
      db.execute(" Create table ${AppConstant.userTable} ( ${AppConstant.columnUserID} integer primary key autoincrement , ${AppConstant.columnName} text, ${AppConstant.columnMobNo} text, ${AppConstant.columnEmail} text, ${AppConstant.columnUserPass} text)");
      db.execute(" Create table ${AppConstant.expTable} ( ${AppConstant.columnExpId} integer primary key autoincrement , ${AppConstant.columnExpTitle} text, ${AppConstant.columnExpDesc} text, ${AppConstant.columnUserID} integer, ${AppConstant.columnExpType} integer, ${AppConstant.columnExpCatId} integer, ${AppConstant.columnExpAmt} real, ${AppConstant.columnExpBal} real, ${AppConstant.columnExpCreatedAt} text )");
    });
  }

  Future<int> createUser ({required UserModel newUser}) async{
    var db= await initDB();

    if(!await checkIfUserAlreadyExists(email: newUser.email)){
      int rowEffected =await db.insert(AppConstant.userTable,newUser.toMap(),);
       return rowEffected > 0 ? 3 : 1;
    }else{
      return 2;
    }
  }

  Future<bool> checkIfUserAlreadyExists({required String email}) async{
    var db= await initDB();

    List<Map<String,dynamic>> users = await db.query(
      AppConstant.userTable,
      where: '${AppConstant.columnEmail} = ?',
      whereArgs: [email],
    );
    return users.isNotEmpty;
  }

  ///1=>success,
  ///2=>email incorrect
  ///3=>pass is wrong!
  Future<int> authenticateUser({required String email, required String pass}) async{
    var db= await initDB();

    if(await checkIfUserAlreadyExists(email: email)){
      List<Map<String,dynamic>> users= await db.query(
        AppConstant.userTable,
        where:  "${AppConstant.columnEmail} =? AND ${AppConstant.columnUserPass} =?",
        whereArgs: [email,pass],
      );

      if (users.isNotEmpty){
        SharedPreferences prefs= await SharedPreferences.getInstance();
        prefs.setInt(AppConstant.pref_user_id, users[0][AppConstant.columnUserID] as int,);
        return 1;
      }else{
        // incorrect pass
        return 3;
      }
    }else{
      // incorrect email
      return 2;
    }
  }

  Future<bool> addExpense({required ExpenseModel newExpanse}) async{
    var db= await initDB();
    SharedPreferences prefs= await SharedPreferences.getInstance();
    int uId=prefs.getInt(AppConstant.pref_user_id) ?? 0;
    newExpanse.userId =uId;

    int rowEffected = await  db.insert(AppConstant.expTable, newExpanse.toMap());

    return rowEffected > 0;
  }

  Future<List<ExpenseModel>> getAllExpenses() async {
    var db = await initDB();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    int uId = prefs.getInt(AppConstant.pref_user_id) ?? 0;

    var allExpMap = await db.query(
      AppConstant.expTable,
      where: "${AppConstant.columnUserID} = ?",
      whereArgs: ["$uId"],
    );

    List<ExpenseModel> allExpensesModel = [];

    for(Map<String, dynamic> eachExp in allExpMap){
      allExpensesModel.add(ExpenseModel.fromMap(eachExp));
    }

    return allExpensesModel;
  }


}


