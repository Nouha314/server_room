import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:server_room/main.dart';

import '../models/user.dart';
import '../my_voids.dart';

class UsersCtr extends GetxController {
  late StreamSubscription<QuerySnapshot> streamSub;

  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 0), () {
      getUsersData(printDet: true);
      //streamingDoc(usersColl,authCtr.cUser.id!);
    });
  }

  Map<String, SrUser> userMap = {};
  List<SrUser> userList = [];
  List<SrUser> foundUsersList = [];
  final TextEditingController typeAheadController = TextEditingController();
  bool shouldLoad = true;
  bool typing = false;

  getUsersData({bool printDet = false}) async {
    if (printDet) print('## downloading users from fireBase...');
    List<DocumentSnapshot> usersData =
        await getDocumentsByColl(usersColl.where('verified', isEqualTo: true));

    // Remove any existing users
    userMap.clear();

    //fill user map
    for (var _user in usersData) {
      //fill userMap
      userMap[_user.id] = SrUserFromMap(_user);
    }

    userList = userMap.entries.map((entry) => entry.value).toList();
    foundUsersList = userList;
    shouldLoad = false;
    if (printDet) print('## < ${userMap.length} > users loaded from database');
    update();
  }

  void runFilterList(String enteredKeyword) {
    print('## running filter ...');
    List<SrUser>? results = [];

    if (enteredKeyword.isEmpty) {
      results = userList;
    } else {
      results = userList
          .where((user) =>
              user.email!.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    foundUsersList = results;
    update();
  }

  clearSelectedProduct() async {
    typeAheadController.clear();
    runFilterList(typeAheadController.text);
    appBarTyping(false);
    update();
  }

  appBarTyping(typ) {
    typing = typ;
    update();
  }

  Widget userCard(SrUser user, {bool requested = false}) {
    double width = MediaQuery.of(navigatorKey.currentContext!).size.width;
    return GestureDetector(onTap: () {
      //selectUser(user);

      child:
      Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          width: width,
          height: 130,
          child: Stack(
            children: [
              Card(
                color: Color(0xff003A44),
                elevation: 50,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white38, width: 2),
                    borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),

                      ///patient simple info
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Image.asset(
                          //   'assets/images/person.png',
                          //   width: 72,
                          // ),
                          SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ///name
                              Text(
                                '${user.name}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                              SizedBox(height: 5),

                              ///email
                              Text(
                                user.email!,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 11),
                              ),
                              SizedBox(height: 5),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (requested)
                Positioned(
                  bottom: 36,
                  right: 25,
                  child: CircleAvatar(
                    //backgroundColor: darkGreen3,
                    radius: 20,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(Icons.add),
                      color: Colors.white,
                      onPressed: () {
                        approveUser(user);
                      },
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  approveUser(SrUser user) {}
}
