import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:server_room/admin/approvedList.dart';
import 'package:server_room/my_voids.dart';
import 'package:server_room/notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:server_room/auth/login.dart';
import 'package:server_room/manage_profile.dart';

import 'history.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _logout() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      //await preferences.clear();
      FirebaseAuth.instance.signOut();
      Get.offAll(() => MyLogin());
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
              ),
              child: const Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Get.back();
                Get.to(() => MyHomePage());
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text('View History'),
              onTap: () {
                Get.back();
                Get.to(() => HistoryView());
              },
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Manage Profile'),
              onTap: () {
                Get.back();

                Get.to(() => ManageProfilePage());
              },
            ),
            if (currentUser.isAdmin)
              ListTile(
                leading: const Icon(Icons.admin_panel_settings),
                title: const Text('Admin Panel'),
                onTap: () {
                  Get.back();
                  Get.to(() => ApprovedListView());
                },
              ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notifications'),
              onTap: () {
                Get.back();
                Get.to(() => NotificationsPage());
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: _logout,
            ),
          ],
        ),
        width: 200,
      ),
      body: const Center(
        child: Text(
          'Hello, welcome to my app!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
