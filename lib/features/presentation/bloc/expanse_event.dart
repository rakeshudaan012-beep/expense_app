import 'package:expenso_app/features/presentation/model/expenso_model.dart';

abstract class ExpenseEvent{}

class AddExpenseEvent extends ExpenseEvent{
  ExpenseModel newExp;
  AddExpenseEvent({required this.newExp});
}
class FetchInitialExpenseEvent extends ExpenseEvent{
  /*int filterFlag;
  FetchInitialExpense({required this.filterFlag});*/
}