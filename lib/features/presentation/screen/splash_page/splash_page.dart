import 'dart:async';
import 'package:expenso_app/app_routes.dart';
import 'package:expenso_app/core/constant/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget{
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),() async {

      SharedPreferences prefs= await SharedPreferences.getInstance();
      int userId= prefs.getInt(AppConstant.pref_user_id) ?? 0;

      String nextPage=AppRoute.login;
      if(userId>0){
        nextPage =AppRoute.dashboard;
      }
      Navigator.pushReplacementNamed(context, nextPage);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppConstant.ic_app,width: 400,height: 250,),
            SizedBox(
              height: 11,
            ),
            Text('Expenso',style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),)
          ],
        ),
      ),
    );
  }
}