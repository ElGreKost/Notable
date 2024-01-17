import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notable/core/app_export.dart';
import 'package:notable/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'firebase_options.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  // ThemeHelper().changeTheme('primary');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (BuildContext context) => AppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notable',
        theme: theme,
        initialRoute: AppRoutes.loginScreen,
        routes: AppRoutes.routes,
      ),
    );
  }
}



