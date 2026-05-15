import 'package:expenso_app/core/constant/app_constants.dart';


class UserModel{
  int? id;
  String name;
  String email;
  String mobNo;
  String? pass;

  UserModel({this.id ,
    required this.name,
    required this.email,
    required this.mobNo,
    this.pass});

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    id: map[AppConstant.columnUserID],
    name: map[AppConstant.columnName],
    email: map[AppConstant.columnEmail],
    mobNo: map[AppConstant.columnMobNo],
  );

  Map<String,dynamic> toMap()=> {
    AppConstant.columnName: name,
    AppConstant.columnMobNo:mobNo,
    AppConstant.columnEmail:email,
    AppConstant.columnUserPass:pass,
  };
}