import 'package:flutter/material.dart';
import 'package:instagramclon/login_page.dart';
import 'package:instagramclon/tab_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RootPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream: FirebaseAuth.instance.authStateChanges(),

      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
//          성공시 데이터가 있다.
          return TabPage(snapshot.data);
        } else {
          return LoginPage();
        }
      },
    );
  }
}
