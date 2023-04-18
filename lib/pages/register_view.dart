import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// RegisterView widget that allows users to register for an account
class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // Initialize email and password controllers
  late final TextEditingController _email;
  late final TextEditingController _password;

  // Initialize the state of the widget
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  // Dispose of email and password controllers
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold widget that sets up the app's UI layout
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'ENTER YOUR EMAIL',
            ),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(
              hintText: 'ENTER YOUR PASSWORD',
            ),
          ),
          // Text button widget that allows users to register with email and password
          TextButton(
            onPressed: () async {
              try {
                final email = _email.text;
                final password = _password.text;
                final userCredential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                print(userCredential);
              } catch (e) {
                // If an exception occurs, check if it is a FirebaseAuthException and handle the error accordingly
                if (e is FirebaseAuthException && e.code == 'weak passsword') {
                  print('User not found');
                } else if (e is FirebaseAuthException &&
                    e.code == 'wrong-password') {
                  print('Wrong Password');
                }
              }
            },
            child: const Text(
              'Register',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Quicksand',
                color: Colors.black54,
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Already Registered? Login here!'),
          )
        ],
      ),
    );
  }
}
