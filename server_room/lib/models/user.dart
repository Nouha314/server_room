import '../my_voids.dart';

class SrUser {
  String? id;
  String? email;
  String? name;
  String? pwd;
  bool isAdmin;
  bool verified;

  SrUser({
    this.id = 'no-id',
    this.email = 'no-email',
    this.name = 'no-name',
    this.isAdmin = true, //change later
    this.verified = false,
    this.pwd = 'no-pwd',
  });
}

SrUser SrUserFromMap(userDoc) {
  SrUser user = SrUser();

  user.id = userDoc.get('id');
  user.email = userDoc.get('email');
  user.pwd = userDoc.get('pwd');
  user.name = userDoc.get('name');
  user.verified = userDoc.get('verified');
  user.isAdmin = userDoc.get('isAdmin');

  print('## User_Props_loaded From database');

  return user;
}

Future<void> getUserInfoByEmail(userEmail) async {
  await usersColl.where('email', isEqualTo: userEmail).get().then((event) {
    var userDoc = event.docs.single;
    currentUser = SrUserFromMap(userDoc);
    printUser(currentUser);
  }).catchError((e) => print("## cant find user in db: $e"));
}

printUser(SrUser user) {
  print('#### USER ####\n'
      '--id: ${user.id} \n'
      '--email: ${user.email} \n'
      '--pwd: ${user.pwd} \n'
      '--name: ${user.name} \n'
      '--verified: ${user.verified} \n'
      '--isAdmin: ${user.isAdmin} \n');
}
