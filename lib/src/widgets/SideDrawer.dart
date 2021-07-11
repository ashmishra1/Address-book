import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:new_app/services/google_services-1.dart';
import 'package:new_app/src/screens/sign_in.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);
  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  bool isSigningOut = false;

  var user = FirebaseAuth.instance.currentUser;

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignIn(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.black12,
            ),
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                    maxRadius: 30,
                    backgroundImage: NetworkImage(user!.photoURL!),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    user!.displayName!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.email,
              color: Colors.white,
            ),
            title: Text(
              user!.email!,
              style: TextStyle(color: Colors.white54),
            ),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.white54),
            ),
            onTap: () async {
              setState(() {
                isSigningOut = true;
              });

              await Authentication.signOut(context: context);

              setState(() {
                isSigningOut = false;
              });

              await Navigator.of(context)
                  .pushReplacement(_routeToSignInScreen());
            },
            //{Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
