import 'package:flutter/material.dart';

class AppRoundedButton extends StatelessWidget{

  VoidCallback onTap;
  String title;
  Color bgColors;
  Color fgColors;
  bool isIcon;
  IconData? mIcon;
  double mWidth;
  Widget? myChild;


  AppRoundedButton({
    this.mWidth=double.infinity,
    required this.onTap,
    required this.title,
    this.bgColors= Colors.orange,
    this.fgColors= Colors.white,
    this.isIcon=false,
    this.mIcon,
    this.myChild

});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: mWidth,
      height: 50,
      child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColors,
        foregroundColor:fgColors
      ),onPressed: onTap,
          child:myChild ?? (isIcon ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(mIcon),
          SizedBox(
            width: 1,
          ),
          Text(title)
        ],
      ):Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),))),
    );
  }
}