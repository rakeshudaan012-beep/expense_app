import 'package:expenso_app/features/presentation/model/expenso_model.dart';

abstract class ExpenseState{}

class ExpenseInitialState extends ExpenseState{}
class ExpenseLoadingSate extends ExpenseState{}
class ExpenseLoadedState extends ExpenseState{
  List<ExpenseModel> allExp;
  ExpenseLoadedState({required this.allExp});
}
class ExpenseErrorState extends ExpenseState{
  String errorMsg;
  ExpenseErrorState({required this.errorMsg});
}