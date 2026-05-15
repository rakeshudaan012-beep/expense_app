import 'package:expenso_app/features/presentation/model/cat_model.dart';
import 'package:flutter/material.dart';


class AppConstant{

  static const String img_cofee='assets/images/coffee.png';
  static const String fast_food='assets/images/fast-food.png';
  static const String gift_box='assets/images/gift-box.png';
  static const String hawaiin_shirt='assets/images/hawaiian-shirt.png';
  static const String hot_pot='assets/images/hot-pot.png';
  static const String ic_app='assets/images/ic_app_logo.png';
  static const String makeup_pouch='assets/images/makeup-pouch.png';
  static const String mobile_transfer='assets/images/mobile-transfer.png';
  static const String music='assets/images/music.png';
  static const String popcorn='assets/images/popcorn.png';
  static const String restaurant='assets/images/restaurant.png';
  static const String shopping_bag='assets/images/shopping-bag.png';
  static const String smart_phone='assets/images/smartphone.png';
  static const String snack='assets/images/snack.png';
  static const String tool='assets/images/tools.png';
  static const String travel='assets/images/travel.png';
  static const String vegetable='assets/images/vegetables.png';

  ///prefs
  static const String pref_user_id='pref_user_id';

  static const String dbName='expensoDB.db';
  static const String expTable='expense';
  ///columns
  static const String columnExpId='e_id';
  static const String columnExpTitle='e_title';
  static const String columnExpDesc='e_desc';
  static const String columnExpAmt='e_amt';
  static const String columnExpBal='e_bal';
  static const String columnExpType='e_type';
  static const String columnExpCatId='e_cat_id';
  static const String columnExpCreatedAt='e_created_at';

  static const String userTable='user';
  ///columns
  static const String columnUserID='u_id';
  static const String columnName='u_name';
  static const String columnEmail='u_email';
  static const String columnMobNo='u_mob_no';
  static const String columnUserPass='u_pass';

  ///cat data
  static final List<CatModel> allCat=[
    CatModel(id: 1, title: 'Snack', imPath: snack),
    CatModel(id: 2, title: 'Travel', imPath: travel),
    CatModel(id: 3, title: 'Shopping', imPath: shopping_bag),
    CatModel(id: 4, title: 'Coffee', imPath: img_cofee),
    CatModel(id: 5, title: 'Fast-Food', imPath: fast_food),
    CatModel(id: 6, title: 'Restaurant', imPath: restaurant),
    CatModel(id: 7, title: 'Movie', imPath: music),
    CatModel(id: 8, title: 'PopCorn', imPath: popcorn),
    CatModel(id: 9, title: 'Tools', imPath: tool),
    CatModel(id: 10, title: 'Delivery', imPath: smart_phone)
  ];


 static final List<Map<String, dynamic>> expenses = const [
    {'category': 'Food', 'amount': 1200.0, 'color': Colors.orange},
    {'category': 'Transport', 'amount': 800.0, 'color': Colors.blue},
    {'category': 'Shopping', 'amount': 1500.0, 'color': Colors.pink},
    {'category': 'Bills', 'amount': 2000.0, 'color': Colors.red},
    {'category': 'Other', 'amount': 500.0, 'color': Colors.green},
  ];


  static final List<Map<String, dynamic>> notifications = const [
    {
      'title': 'Expense Added',
      'message': 'You added ₹250 for Food',
      'time': '2 min ago',
      'icon': Icons.restaurant,
      'color': Colors.orange,
    },
    {
      'title': 'Budget Alert',
      'message': 'You used 80% of your monthly budget',
      'time': '1 hour ago',
      'icon': Icons.warning_amber,
      'color': Colors.red,
    },
    {
      'title': 'Daily Reminder',
      'message': 'Don\'t forget to log today\'s expenses',
      'time': '5 hours ago',
      'icon': Icons.alarm,
      'color': Colors.blue,
    },
    {
      'title': 'Expense Added',
      'message': 'You added ₹1500 for Shopping',
      'time': 'Yesterday',
      'icon': Icons.shopping_bag,
      'color': Colors.pink,
    },
    {
      'title': 'Monthly Summary',
      'message': 'Your November summary is ready',
      'time': '2 days ago',
      'icon': Icons.bar_chart,
      'color': Colors.purple,
    },
    {
      'title': 'Bill Reminder',
      'message': 'Electricity bill due in 3 days',
      'time': '3 days ago',
      'icon': Icons.receipt_long,
      'color': Colors.green,
    },
  ];


 static final List<Map<String, dynamic>> menuItems = const [
    {'icon': Icons.person_outline, 'title': 'Edit Profile'},
    {'icon': Icons.currency_rupee, 'title': 'Currency'},
    {'icon': Icons.notifications_outlined, 'title': 'Notifications'},
    {'icon': Icons.dark_mode_outlined, 'title': 'Dark Mode'},
    {'icon': Icons.lock_outline, 'title': 'Change Password'},
    {'icon': Icons.help_outline, 'title': 'Help & Support'},
    {'icon': Icons.info_outline, 'title': 'About App'},
  ];
}