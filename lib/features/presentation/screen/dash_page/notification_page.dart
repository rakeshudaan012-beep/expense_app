import 'package:expenso_app/core/constant/app_constants.dart';
import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.purpleAccent,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: AppConstant.notifications.length,
        itemBuilder: (context, index) {
          final item = AppConstant.notifications[index];

          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6),
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: CircleAvatar(
                backgroundColor: item['color'].withOpacity(0.2),
                child: Icon(item['icon'], color: item['color']),
              ),
              title: Text(
                item['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(item['message']),
              ),
              trailing: Text(
                item['time'],
                style: const TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }
}