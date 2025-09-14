import 'profile_api_provider.dart';
import '../models/user_model.dart';

class ProfileRepository {
  final ProfileApiProvider apiProvider;
  ProfileRepository(this.apiProvider);

  // Si tu API tiene endpoint para 1 usuario, implementa fetchUser ahí.
  // Si no, aquí devolvemos el primer usuario de la lista.
  Future<UserModel> fetchUser() async {
    final List<UserModel> users = await apiProvider.fetchUsers();
    if (users.isNotEmpty) {
      return users.first;
    } else {
      throw Exception('No hay usuarios disponibles');
    }
  }

  // (Opcional) mantiene fetchUsers si la necesitas en otro lugar
  Future<List<UserModel>> fetchUsers() => apiProvider.fetchUsers();
}
