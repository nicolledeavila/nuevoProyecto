import 'dart:convert';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:http/http.dart' as http;
import 'package:proyect/data/providers/api_provider.dart';

import '../models/user_model.dart';

class UserRepository {
  UserRepository([ApiProvider? apiProvider]);

  final baseUrl = kIsWeb ? "http://127.0.0.1:3000" : "http://10.0.2.2:3000";

  /// 👉 Registrar un usuario
  Future<UserModel> registerUser(UserModel user) async {
    final url = Uri.parse("$baseUrl/api/users/register");

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "name": user.name,
        "email": user.email,
        "password": user.password,
      }),
    );

    print("Status code (register): ${response.statusCode}");
    print("Body (register): ${response.body}");

    // ✅ Si el código es 2xx tratamos como éxito
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.trim().isEmpty) {
        // Si la API no devuelve nada, usamos el mismo user enviado
        return user;
      }

      try {
        final decoded = jsonDecode(response.body);

        // Normalizamos el JSON devuelto (puede venir como Map o List)
        Map<String, dynamic> data;
        if (decoded is List && decoded.isNotEmpty && decoded[0] is Map) {
          data = Map<String, dynamic>.from(decoded[0]);
        } else if (decoded is Map) {
          data = Map<String, dynamic>.from(decoded);
        } else {
          return user; // devolvemos el usuario enviado si no hay formato válido
        }

        return UserModel(
          name: data['name']?.toString() ?? user.name,
          email: data['email']?.toString() ?? user.email,
          password: data['password']?.toString() ?? user.password,
        );
      } catch (e) {
        print("⚠️ Error parseando JSON del registro: $e");
        // Si falla el parseo, devolvemos el user enviado
        return user;
      }
    } else {
      throw Exception(
        "Error en el registro: status ${response.statusCode} body: ${response.body}",
      );
    }
  }

  /// 👉 Obtener lista de usuarios
  Future<List<UserModel>> fetchUsers() async {
    final url = Uri.parse("$baseUrl/api/users");
    final response = await http.get(url);

    print("Status code (fetchUsers): ${response.statusCode}");
    print("Body (fetchUsers): ${response.body}");

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.trim().isEmpty) return [];

      try {
        final decoded = jsonDecode(response.body);
        final List<dynamic> list = decoded is List ? decoded : [];

        return list.map((json) {
          final map = Map<String, dynamic>.from(json);
          return UserModel(
            name: map['name']?.toString() ?? '',
            email: map['email']?.toString() ?? '',
            password: map['password']?.toString() ?? '',
          );
        }).toList();
      } catch (e) {
        print("⚠️ Error parseando JSON de usuarios: $e");
        return [];
      }
    } else {
      throw Exception("Error cargando usuarios: ${response.body}");
    }
  }
}
