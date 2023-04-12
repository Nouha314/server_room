import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:random_avatar/random_avatar.dart';

import '../models/user.dart';
import 'approvedListCtr.dart';

class RequestsList extends StatefulWidget {
  const RequestsList({super.key});

  @override
  State<RequestsList> createState() => _RequestsListState();
}

class _RequestsListState extends State<RequestsList> {
  final UsersCtr gc = Get.find<UsersCtr>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      //appBar: searchAppBar(),
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
        child: GetBuilder<UsersCtr>(
          builder: (ctr) => (gc.userListReq.isNotEmpty)
              ? ListView.builder(
                  //itemExtent: 130,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  shrinkWrap: true,
                  itemCount: gc.userListReq.length,
                  itemBuilder: (BuildContext context, int index) {
                    SrUser user = gc.foundUsersList[index];
                    bool requested = true;
                    //setState(() {});
                    //String key = gc.foundUsersMap.keys.elementAt(index);
                    //return gc.userCard(gc.foundUsersList[index]);
                    return Container(
                      child: Card(
                        shadowColor: Colors.black,
                        //color: Colors.blueGrey,
                        child: ListTile(
                          trailing:
                              Row(mainAxisSize: MainAxisSize.min, children: [
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
                          ]),
                          leading:
                              RandomAvatar('saytoonz', height: 50, width: 50),
                          title: Text(user.email!),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                  })
              : gc.shouldLoad
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Center(
                      child: Text(
                        'no requests found',
                        style: TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}
