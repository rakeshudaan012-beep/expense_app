import 'package:expenso_app/app_routes.dart';
import 'package:expenso_app/features/auth/bloc/user_bloc.dart';
import 'package:expenso_app/features/auth/data/db_helper.dart';
import 'package:expenso_app/features/presentation/bloc/expanse_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main(){
  runApp(MultiBlocProvider(providers: [
     BlocProvider(create: (context)=>UserBloc(dbHelper: DBHelper.getInstance()),),
    BlocProvider(create: (context)=>ExpenseBloc(dbHelper: DBHelper.getInstance()),)
  ], child: MyApp()));
}
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:  'Flutter Demo',
      initialRoute: AppRoute.splash,
      routes: AppRoute.mRoutes,
    );
  }
}