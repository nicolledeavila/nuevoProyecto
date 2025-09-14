import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class RegisterApiProvider {
  // 👇 Cambiado: ahora el baseUrl solo hasta /users
  final String baseUrl = "http://localhost:3000/api/users";

  Future<UserModel> registerUser(UserModel user) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register"), // <- aquí sí encaja con tu backend
      headers: {"Content-Type": "application/json"},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error al registrar usuario: ${response.body}");
    }
  }
}
