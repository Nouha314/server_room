import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

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
          builder: (ctr) => (gc.foundUsersList.isNotEmpty)
              ? ListView.builder(
                  //itemExtent: 130,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  shrinkWrap: true,
                  itemCount: gc.foundUsersList.length,
                  itemBuilder: (BuildContext context, int index) {
                    //setState(() {});

                    //String key = gc.foundUsersMap.keys.elementAt(index);
                    return gc.userCard(gc.foundUsersList[index],
                        requested: true);
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
