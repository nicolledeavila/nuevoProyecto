import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class ProfileApiProvider {
  final String baseUrl = "http://localhost:3000/api/users";

  Future<List<UserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse(baseUrl));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => UserModel.fromJson(e)).toList();
    } else {
      throw Exception("Error al obtener usuarios: ${response.body}");
    }
  }
}
