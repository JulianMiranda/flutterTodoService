import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:cotopaxi/global/enviroment.dart';
import 'package:cotopaxi/services/aut_service.dart';
import 'package:cotopaxi/models/user.dart';
import 'package:cotopaxi/models/messages_response.dart';

class ChatService with ChangeNotifier {
  User usuarioPara;
  Future<List<Mensaje>> getChat(String userId) async {
    final response = await http.get('${Environment.apiUrl}/mensajes/$userId',
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        });
    final mensajesResponse = messageResponseFromJson(response.body);
    return mensajesResponse.mensajes;
  }
}
