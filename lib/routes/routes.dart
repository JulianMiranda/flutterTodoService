import 'package:flutter/material.dart';

import 'package:cotopaxi/pages/chat_page.dart';
import 'package:cotopaxi/pages/loading_page.dart';
import 'package:cotopaxi/pages/login_page.dart';
import 'package:cotopaxi/pages/register_page.dart';
import 'package:cotopaxi/pages/user_page.dart';


final Map<String, Widget Function(BuildContext)> appRoutes = {

  'usuarios': ( _ ) => UsersPage(),
  'chat'    : ( _ ) => ChatPage(),
  'login'   : ( _ ) => LoginPage(),
  'register': ( _ ) => RegisterPage(),
  'loading' : ( _ ) => LoadingPage(),

};
