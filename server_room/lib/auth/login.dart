import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:server_room/models/user.dart';
import 'package:server_room/my_voids.dart';

import '../home_page.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> loginButtonPressed() async {
    // Check if email and password fields are not empty
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      dialogShow('Error', 'Please enter your email and password');

      return;
    }

    try {
      print('## try to signIn');

      //try signIn
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      )
          .then((value) async {
        //account found

        await getUserInfoByEmail(_emailController.text).then((value) {
          Get.offAll(() => MyHomePage());
          toastShow('Welcome');
        });
      });

      // signIn error
    } on FirebaseAuthException catch (e) {
      print('## error signIn => ${e.message}');
      if (e.code == 'user-not-found') {
        dialogShow('User not found', '');

        print('## user not found');
      } else if (e.code == 'wrong-password') {
        dialogShow('Wrong password', '');

        print('## wrong password');
      }
    } catch (e) {
      print('## catch err in signIn user_auth: $e');
    }
    // Navigate to home page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 40.0),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Text(
                    'Welcome back\n',
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Password',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: loginButtonPressed,
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(33, 150, 243, 1),
                ),
                child: const Text('Login'),
              ),
              const SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'register');
                },
                style: TextButton.styleFrom(
                  primary: const Color.fromRGBO(33, 150, 243, 1),
                ),
                child: const Text('Create an account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
