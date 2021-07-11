import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_app/blocs/application_blocs.dart';

import 'package:new_app/src/screens/sign_in.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: SignIn(),
      ),
    );
  }
}
