import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cotopaxi/pages/login_page.dart';
import 'package:cotopaxi/pages/user_page.dart';
import 'package:cotopaxi/services/aut_service.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Cargando...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final sending = await authService.isLoggedIn();

    if(sending){
//TODO:
 Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: ( _, __, ___ ) => UsersPage(),
          transitionDuration: Duration(milliseconds: 0)
        )
      );
    } else {

 Navigator.pushReplacement(
        context, 
        PageRouteBuilder(
          pageBuilder: ( _, __, ___ ) => LoginPage(),
          transitionDuration: Duration(milliseconds: 0)
        )
      );
    }
  }
}
