import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:random_avatar/random_avatar.dart';
import 'package:server_room/admin/requestsList.dart';

import '../models/user.dart';
import 'approvedListCtr.dart';

class ApprovedListView extends StatefulWidget {
  @override
  State<ApprovedListView> createState() => _ApprovedListViewState();
}

class _ApprovedListViewState extends State<ApprovedListView> {
  final UsersCtr gc = Get.put<UsersCtr>(UsersCtr());

  searchAppBar() {
    return AppBar(
      backgroundColor: Color(0xff024855),
      toolbarHeight: 60.0,
      title: GetBuilder<UsersCtr>(
          //id: 'appBar',
          builder: (_) {
        return gc.typing
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0),
                child: SizedBox(
                  height: 40,
                  child: Container(
                      //margin: EdgeInsets.symmetric(vertical: 50),
                      decoration: BoxDecoration(
                        color: Color(0xff01333c),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      //margin: EdgeInsets.all(20.0),
                      //alignment: Alignment.topLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 0.0),

                        ///TextFormField
                        child: TextFormField(
                          autocorrect: true,
                          cursorColor: Colors.white54,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.white),
                          textAlign: TextAlign.start,
                          controller: gc.typeAheadController,
                          autofocus: true,
                          onChanged: (input) {
                            gc.runFilterList(input);
                          },
                          decoration: InputDecoration(
                            //filled: true,

                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            fillColor: Colors.green,
                            hintStyle: const TextStyle(
                              color: Colors.white60,
                            ),

                            hintText: 'search for user'.tr,

                            contentPadding: EdgeInsets.only(
                                right: 10.0, left: 10.0, bottom: 10),
                          ),
                        ),
                      )),
                ),
              )
            : Text('Users List');
      }),
      actions: <Widget>[
        GetBuilder<UsersCtr>(
            //id: 'appBar',
            builder: (_) {
          return !gc.typing
              ? IconButton(
                  padding: EdgeInsets.only(right: 15.0),
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    gc.appBarTyping(true);
                  },
                )
              : IconButton(
                  padding: EdgeInsets.only(right: 15.0),
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    gc.clearSelectedProduct();
                    setState(() {});
                  },
                );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: searchAppBar(),
      body: Container(
        alignment: Alignment.topCenter,
        width: width,
        height: height,
        // decoration: const BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/images/Landing page – 1.png"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Column(
          children: [
            GetBuilder<UsersCtr>(
              builder: (ctr) => (gc.foundUsersList.isNotEmpty)
                  ? SingleChildScrollView(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          //itemExtent: 130,
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 5),
                          //shrinkWrap: true,
                          itemCount: gc.foundUsersList.length,
                          itemBuilder: (BuildContext context, int index) {
                            SrUser user = gc.foundUsersList[index];
                            bool requested = false;
                            //setState(() {});
                            //String key = gc.foundUsersMap.keys.elementAt(index);
                            //return gc.userCard(gc.foundUsersList[index]);
                            return Container(
                              child: Card(
                                shadowColor: Colors.black,
                                //color: Colors.blueGrey,
                                child: ListTile(
                                  trailing: requested
                                      ? Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                ),
                                                onPressed: () {},
                                                tooltip: "Approve",
                                              ),
                                              IconButton(
                                                icon: Icon(
                                                  Icons.close,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {},
                                                tooltip: "Reject",
                                              ),
                                            ])
                                      : Container(),
                                  leading: RandomAvatar('saytoonz',
                                      height: 50, width: 50),
                                  title: Text(user.email!),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 4),
                                      Text("Password: ${user.pwd}"),
                                      SizedBox(height: 4),
                                      Text("Name: ${user.name}"),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    )
                  : gc.shouldLoad
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Center(
                          child: Text(
                            'no users found',
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Container(
        child: Container(
          height: 40.0,
          width: 130.0,
          child: FittedBox(
            child: FloatingActionButton.extended(
              onPressed: () {
                Get.to(() => RequestsList());
              },
              heroTag: '.Requests',
              backgroundColor: Colors.green,
              label: Text('Requests'),
            ),
          ),
        ),
      ),
    );
  }
}
