import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notable/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'firebase_options.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // const FirebaseOptions firebaseOptions = FirebaseOptions(
  //   apiKey: 'AIzaSyC_t7R-Bx1iqBoAmsfNhRaJj4s0wyEBHG8',
  //   authDomain: 'notabledb.firebaseapp.com',
  //   projectId: 'notabledb',
  //   storageBucket: 'notabledb.appspot.com',
  //   messagingSenderId: '689719737579',
  //   appId: '1:689719737579:android:2542b3d80c245ce19452ae',
  //   //measurementId: 'your-measurement-id',
  // );

  ///Please update theme as per your need if required.
  // ThemeHelper().changeTheme('primary');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (BuildContext context) => AppState(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.loginsignupScreen,
        // static Map<String, WidgetBuilder> for connections str->Widget
        routes: AppRoutes.routes,
      ),
    );
  }
}



