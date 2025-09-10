import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user_model.dart';

class ApiProvider {
  final String baseUrl = "http://10.0.2.2:3000/api/users";
  // Para Android Emulator: 10.0.2.2
  // iOS Simulator: http://localhost:3000/api/users
  // Dispositivo físico: http://TU_IP_LOCAL:3000/api/users

  Future<UserModel> registerUser(UserModel user) async {
    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {"Content-Type": "application/json"},
      body: json.encode(user.toJson()),
    );

    if (response.statusCode == 201) {
      return UserModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Error al registrar usuario: ${response.body}");
    }
  }

  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception("Error al obtener usuarios");
    }
  }
}
