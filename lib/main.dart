// Import necessary packages and files

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_auth/pages/login_view.dart';
import 'package:login_auth/pages/register_view.dart';

import 'firebase_options.dart';

// Main function to start the app
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

// MyApp widget that is the root of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
// MaterialApp widget that sets up the app's theme and initial page
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomePage(),
      //creatiing routes for linking the pages
      initialRoute: '/',
      routes: {
        '/login/': (context) => LoginView(),
        'register/': (context) => const RegisterView(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set up the app bar with a title
      appBar: AppBar(
        title: const Text('Home'),
      ),
      // Use a FutureBuilder to asynchronously initialize Firebase and build the login view
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // final user = FirebaseAuth.instance.currentUser;
              // print('user');
              // if (user?.emailVerified ?? false) {
              //   print("YOU ARE VERIFIED USER");
              // } else {
              //   return const VerifyEmailView();
              // }
              // return const Text('Done');
              return LoginView();
            default:
              return const Text('LOADING...');
          }
        },
      ),
    );
  }
}

//future is supposed to return a widget something to display on the screen
class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text('Please Verify your email address'),
      TextButton(
          onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
          },
          child: const Text('Send Email verfication'))
    ]);
  }
}
