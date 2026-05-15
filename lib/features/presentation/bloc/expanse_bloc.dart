import 'package:expenso_app/features/auth/data/db_helper.dart';
import 'package:expenso_app/features/presentation/bloc/expanse_event.dart';
import 'package:expenso_app/features/presentation/bloc/expense_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent,ExpenseState>{
  DBHelper dbHelper;
  ExpenseBloc ({required this.dbHelper}): super(ExpenseInitialState()){


    on<AddExpenseEvent>((event,emit) async{
      emit(ExpenseLoadingSate());
        bool isAdded= await dbHelper.addExpense(newExpanse: event.newExp);
        if(isAdded){
          var allExp =await dbHelper.getAllExpenses();
          emit(ExpenseLoadedState(allExp: allExp));
        }else{
          emit(ExpenseErrorState(errorMsg: 'Something is wrong!'));
        }
    });


    on<FetchInitialExpenseEvent>((event,emit) async{
          emit(ExpenseLoadingSate());
          var allExp =await dbHelper.getAllExpenses();
          emit(ExpenseLoadedState(allExp: allExp));
    });
  }
}