import 'package:expenso_app/core/constant/app_constants.dart';

class ExpenseModel{
  int? id;
  int? userId;
  String title;
  String desc;
  num amt;
  num bal;
  int expType;
  int catId;
  int createdAt;

  ExpenseModel({
    this.id,
    this.userId,
    required this.title,
    required this.desc,
    required this.amt,
    required this.bal,
    required this.catId,
    required this.createdAt,
    required this.expType,
});

  factory ExpenseModel.fromMap(Map<String,dynamic> map)=> ExpenseModel(
      id: map[AppConstant.columnExpId],
    userId: map[AppConstant.columnUserID],
    title: map[AppConstant.columnExpTitle],
    desc: map[AppConstant.columnExpDesc],
    amt: map[AppConstant.columnExpAmt],
    bal: map[AppConstant.columnExpBal],
    expType: map[AppConstant.columnExpType],
    catId: map[AppConstant.columnExpCatId],
    createdAt: int.parse(map[AppConstant.columnExpCreatedAt]),
  );

  Map<String,dynamic> toMap()=>{
      AppConstant.columnUserID:userId,
      AppConstant.columnExpTitle:title,
      AppConstant.columnExpDesc:desc,
      AppConstant.columnExpAmt:amt,
      AppConstant.columnExpBal:bal,
      AppConstant.columnExpCatId:catId,
      AppConstant.columnExpCreatedAt:createdAt.toString(),
      AppConstant.columnExpType:expType,

  };
}