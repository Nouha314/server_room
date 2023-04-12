import 'package:flutter/material.dart';

class ManageProfilePage extends StatefulWidget {
  const ManageProfilePage({Key? key}) : super(key: key);

  @override
  _ManageProfilePageState createState() => _ManageProfilePageState();
}

class _ManageProfilePageState extends State<ManageProfilePage> {
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manage Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your email";
                  } else if (!value.contains("@")) {
                    return "Please enter a valid email address";
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value ?? "";
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your password";
                  } else if (value.length < 8) {
                    return "Password must be at least 8 characters long";
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value ?? "";
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Perform the modifications and show a success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text("Profile modified successfully!")),
                      );
                    }
                  },
                  child: const Text("Change"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
