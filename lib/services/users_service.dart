import 'package:http/http.dart' as http;

import 'package:cotopaxi/global/enviroment.dart';
import 'package:cotopaxi/models/user.dart';
import 'package:cotopaxi/services/aut_service.dart';
import 'package:cotopaxi/models/users_response.dart';

class UserService {
  Future<List<User>> getUsuarios() async {
    try {
      final response = await http.get('${Environment.apiUrl}/usuarios',
          headers: {
            'Content-Type': 'application/json',
            'x-token': await AuthService.getToken()
          });
      final userResponse = userResponseFromJson(response.body);
      return userResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
