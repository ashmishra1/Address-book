import 'package:flutter/material.dart';
import 'package:new_app/blocs/application_blocs.dart';
import 'package:provider/provider.dart';

class Enter extends StatelessWidget {
  const Enter({Key? key}) : super(key: key);
  Widget buildLoading() => Stack(
        fit: StackFit.expand,
        children: [
          Center(child: CircularProgressIndicator()),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ApplicationBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark(),
        home: Enter(),
      ),
    );
  }
}
