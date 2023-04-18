// Import necessary packages and files
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Create a StatefulWidget for the Login View
class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

// Create the State class for the Login View
class _LoginViewState extends State<LoginView> {
  // Initialize two TextEditingController objects for email and password input
  late final TextEditingController _email;
  late final TextEditingController _password;

  // Set up the TextEditingController objects in initState()
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  // Dispose of the TextEditingController objects when the State is disposed
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold widget provides a basic structure for the app view
    return Column(
      children: [
        // Set up a text field for email input
        TextField(
          controller: _email,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'ENTER YOUR EMAIL',
          ),
        ),
        // Set up a text field for password input
        TextField(
          controller: _password,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(
            hintText: 'ENTER YOUR PASSWORD',
          ),
        ),
        // Set up a button to handle login functionality
        TextButton(
          onPressed: () async {
            final email = _email.text;
            final password = _password.text;
            // Use a try block to catch any exceptions that may occur during login
            bool isUserNotFound = false;
            try {
              final userCredential =
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                email: email,
                password: password,
              );
              // If login is successful, print the userCredential object to the console
              print(userCredential);
            } catch (e) {
              // If an exception occurs, check if it is a FirebaseAuthException and handle the error accordingly
              if (e is FirebaseAuthException && e.code == 'user-not-found') {
                print('User not found');
              } else if (e is FirebaseAuthException &&
                  e.code == 'wrong-password') {
                print('Wrong Password');
              }
            }
          },
          // Set up the button text and style
          child: Text('Login'),
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.black26,
          ),
        ),
        /*creating a text button that will link
          link the register view to the login view */
        TextButton(
          onPressed: () {
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/register/', (route) => false);
          },
          child: Text('NOT REGISTERED YET? REGISTER HERE!'),
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            backgroundColor: Colors.black26,
          ),
        ),
      ],
    );
  }
}
