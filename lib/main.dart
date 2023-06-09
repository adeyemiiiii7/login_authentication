// Import necessary packages and files

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_auth/pages/login_view.dart';
import 'package:login_auth/pages/register_view.dart';
import 'package:login_auth/pages/verify_email_view.dart';

import 'firebase_options.dart';
import 'dart:developer' as devtools show log;

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
        primarySwatch: MaterialColor(
          0xFFFFFFFF,
          <int, Color>{
            50: Color.fromARGB(179, 145, 141, 141),
            100: Color.fromARGB(179, 165, 157, 157),
            200: Color.fromARGB(179, 159, 153, 153),
            300: Color.fromARGB(179, 180, 176, 176),
            400: Color.fromARGB(179, 104, 103, 103),
            500: Color.fromARGB(179, 107, 106, 106),
            600: Color.fromARGB(179, 84, 82, 82),
            700: Color.fromARGB(179, 86, 85, 85),
            800: Color.fromARGB(179, 106, 104, 104),
            900: Color.fromARGB(179, 90, 88, 88),
          },
        ),
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
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                print('hello world');
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return LoginView();
            }

          default:
            return const Text('LOADING...');
        }
      },
    );
  }
}

enum MenuAction { logout }

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) {
              switch (value) {
                
              }
              devtools.log(value.toString());
            },
            itemBuilder: (context) {
              return [
                const PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text('Log Out'),
                ),
              ];
            },
          ),
        ],
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sign out'),
        content: const Text('Are you sure you want sign out?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel')),
          TextButton(onPressed: () {}, child: const Text('Logout')),
        ],
      );
    },
  ).then((value) => value ?? false);
}
