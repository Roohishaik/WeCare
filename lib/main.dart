import 'package:flutter/material.dart';
import 'package:wecare/components/sign_upform.dart';
import 'package:wecare/screens/auth_page.dart';
import 'package:wecare/screens/booking_page.dart';
import 'package:wecare/screens/doctor_details.dart';
import 'package:wecare/screens/success_book.dart';
import 'package:wecare/utils/config.dart';
import 'package:wecare/utils/main_layout.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

// this is for push navigator
// A GlobalKey is a unique identifier for a widget that allows other widgets to
// refer to it in order to access its properties or methods.
// In this case, the navigatorKey is being used to access the NavigatorState of the widget tree.

// The NavigatorState manages the navigation stack,
// which keeps track of the order in which screens are displayed in the app.
// By using a GlobalKey to access the NavigatorState,
// you can perform actions such as pushing and popping screens from the navigation stack programmatically.
  static final navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //defining ThemeData here
    return MaterialApp(
      navigatorKey: navigatorKey,
      title: 'WeCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        //pre defined input decoration
        inputDecorationTheme: const InputDecorationTheme(
          focusColor: Config.primaryColor,
          border: Config.outlinedBorder,
          focusedBorder: Config.focusBorder,
          errorBorder: Config.errorBorder,
          floatingLabelStyle: TextStyle(color: Config.primaryColor),
          prefixIconColor: Colors.black38,
        ),
        scaffoldBackgroundColor: Colors.white,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Config.primaryColor,
          selectedItemColor: Colors.white,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey.shade700,
          elevation: 10,
          type: BottomNavigationBarType.fixed,
        ),
      ),
      initialRoute: '/',
      routes: {
        //this is initital route of the app
        //which is auth page (login and signup)
        '/': (context) => const AuthPage(),

        //this if for main layout after login
        'main': (context) => const MainLayout(),
        'doc_details': (context) => const DoctorDetails(),
        'booking_page': (context) => const BookingPage(),
        'success_booking': (context) => const AppointmentBooked(),
      },
    );
  }
}
