import 'package:expenso_app/features/presentation/screen/add_expences_page/add_expense_page.dart';
import 'package:expenso_app/features/presentation/screen/dash_page/dash_page.dart';
import 'package:expenso_app/features/presentation/screen/login_login/login_page.dart';
import 'package:expenso_app/features/presentation/screen/singup_page/signup_page.dart';
import 'package:expenso_app/features/presentation/screen/splash_page/splash_page.dart';
import 'package:flutter/cupertino.dart';

class AppRoute {


  static const String splash='/';
  static const String login='login.page';
  static const String signup='/signUp';
  static const String dashboard='/dashboard';
  static const String addExpense='/addExpense';
  static const String status='/status';


  static Map<String,WidgetBuilder> mRoutes={
    splash :(_)=>SplashPage(),
    login :(_)=> LoginPage(),
    signup :(_)=> SignupPage(),
    dashboard :(_)=> DashPage(),
    addExpense:(_)=>AddExpensePage(),
  };

}
