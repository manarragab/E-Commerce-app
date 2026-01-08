import 'package:ecommerce_app/firebase_options.dart';
import 'package:ecommerce_app/res/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'my_app.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting();

  await init();

  // Check before initializing
  // if (Firebase.apps.isEmpty) {
  //   await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.currentPlatform,
  //   );
  // }

//   await FirebaseMessaging.instance.getInitialMessage();

  runApp(const MyApp());
}
