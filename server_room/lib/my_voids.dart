import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:server_room/main.dart';
import 'package:server_room/models/user.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

SrUser currentUser = SrUser();

var usersColl = FirebaseFirestore.instance.collection('users');

Future<List<DocumentSnapshot>> getDocumentsByColl(coll) async {
  QuerySnapshot snap = await coll.get();

  final List<DocumentSnapshot> documentsFound = snap.docs;

  print('## collection docs number => (${documentsFound.length})');

  return documentsFound;
}

toastShow(text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0);
}

dialogShow(title, desc, {bool isSuccessful = false, bool autoHide = false}) {
  AwesomeDialog(
    autoDismiss: true,
    context: navigatorKey.currentContext!,
    dismissOnBackKeyPress: false,
    headerAnimationLoop: false,
    dismissOnTouchOutside: false,
    animType: AnimType.leftSlide,
    dialogType: isSuccessful ? DialogType.success : DialogType.error,
    //showCloseIcon: true,
    title: title,
    autoHide: autoHide ? Duration(seconds: 1) : null,

    btnOkColor: isSuccessful ? Color(0xFF00B962) : Color(0xFFD0494A),
    descTextStyle: TextStyle(
      height: 1.8,
      fontSize: 14,
    ),
    desc: desc,
    btnOkText: 'Ok',

    btnOkOnPress: () {},
    // onDissmissCallback: (type) {
    //   debugPrint('## Dialog Dissmiss from callback $type');
    // },
    //btnOkIcon: Icons.check_circle,
  ).show();
}

void dialogShow0(String title, String content) {
  showDialog(
    context: navigatorKey.currentContext!,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      );
    },
  );
}

/// add DOCUMENT to fireStore
Future<void> addDocument(
    {required fieldsMap, required String collName, bool addID = true}) async {
  CollectionReference coll = FirebaseFirestore.instance.collection(collName);

  coll.add(fieldsMap).then((value) async {
    print("## DOC ADDED TO <$collName>");

    //add id to doc
    if (addID) {
      String docID = value.id;
      //set id
      coll.doc(docID).update(
        {
          'id': docID,
        },
        //SetOptions(merge: true),
      );
    }
  }).catchError((error) {
    print("## Failed to add doc to <$collName>: $error");
  });
}
