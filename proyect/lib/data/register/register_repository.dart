import 'register_api_provider.dart';
import '../models/user_model.dart';

class RegisterRepository {
  final RegisterApiProvider apiProvider;
  RegisterRepository(this.apiProvider);

  Future<UserModel> registerUser(UserModel user) {
    return apiProvider.registerUser(user);
  }
}
