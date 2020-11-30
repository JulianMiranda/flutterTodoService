import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cotopaxi/routes/routes.dart';
import 'package:cotopaxi/services/socket_service.dart';
import 'package:cotopaxi/services/aut_service.dart';
import 'package:cotopaxi/services/chat_service.dart';
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

       providers: [
         ChangeNotifierProvider(create: (_) => AuthService()),
         ChangeNotifierProvider(create: (_) => SocketService()),
         ChangeNotifierProvider(create: (_) => ChatService()),
       ],
       child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cotopaxi',
        initialRoute: 'loading',
        routes: appRoutes,
      ),
    );
  }
}