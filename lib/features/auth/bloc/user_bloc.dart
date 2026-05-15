import 'package:expenso_app/features/auth/bloc/user_event.dart';
import 'package:expenso_app/features/auth/bloc/user_state.dart';
import 'package:expenso_app/features/auth/data/db_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent,UserState>{
  DBHelper dbHelper;
  UserBloc ({required this.dbHelper}):super (UserInitialState()){
    on<RegisterUserEvent>((event,emit) async{
      emit(UserLoadingState());
       int check= await dbHelper.createUser(newUser: event.mUser);

       if(check==3){
         emit(UserSuccessSate());
       }else if(check==2){
         emit(UserFailureState(errorMsg: 'Email Already exits'));
       }else{
         emit(UserFailureState(errorMsg: 'Something is wrong '));
       }


    });

    on<LoginUserEvent>((event,emit) async {
      emit (UserLoadingState());

      int check = await dbHelper.authenticateUser(email: event.email, pass: event.pass);

       if(check==1){
         emit(UserSuccessSate());
       }else if(check==3){
         emit(UserFailureState(errorMsg: 'Password is incorrect '));
       }else{
         emit(UserFailureState(errorMsg: 'Email is Invalid!'));
       }
    });
  }
}