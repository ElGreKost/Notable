import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notable/core/app_export.dart';
import 'package:notable/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'backend/app_state.dart';
import 'backend/feature_tester.dart';
import 'backend/tree_note_manager.dart';
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (BuildContext context) => AppState()),
        ChangeNotifierProvider(create: (BuildContext context) => TreeNoteManager()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Notable',
        theme: theme,
        // theme: ThemeData.dark(),
        initialRoute: AppRoutes.loginScreen,
        routes: AppRoutes.routes,
        // home: TreeNoteManagerTestPage()
      ),
    );
  }
}
