import 'package:expenso_app/app_routes.dart';
import 'package:expenso_app/features/presentation/screen/add_expences_page/add_expense_page.dart';
import 'package:expenso_app/features/presentation/screen/dash_page/account_page.dart';
import 'package:expenso_app/features/presentation/screen/dash_page/notification_page.dart';
import 'package:expenso_app/features/presentation/screen/dash_page/stats_page.dart';
import 'package:flutter/material.dart';

import 'nav_home_page.dart';

class DashPage extends StatefulWidget{
  const DashPage({super.key});
  @override
  State<DashPage> createState() => _DashPageState();
}

class _DashPageState extends State<DashPage> {
  int selectedIndex=0;
  List<Widget> myPages=[
    NavHomePage(),
    ChartPage(),
   AddExpensePage(),
    NotificationPage(),
    AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: myPages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.purpleAccent,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 26,
          unselectedItemColor: Colors.grey,
          currentIndex: selectedIndex,
          onTap: (index){
            if (index==2){
              Navigator.pushNamed(context, AppRoute.addExpense);
            }else {
                selectedIndex = index;
                setState((){});
            }
          }
          ,items: [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined),label: 'Stats'),
        BottomNavigationBarItem(icon:Container(padding: EdgeInsets.all(11),decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(11)),child: Icon(Icons.add,color:Colors.white,),),label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications_active_outlined),label: 'Notification'),
        BottomNavigationBarItem(icon: Icon(Icons.account_circle_outlined),label: 'Account'),
      ]),
    );
  }
}