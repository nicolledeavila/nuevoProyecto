import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/user_repository.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc(this.userRepository) : super(UserInitial()) {
    on<RegisterUserEvent>(_onRegisterUser);
    on<LoadUsersEvent>(_onLoadUsers);
  }

  Future<void> _onRegisterUser(
      RegisterUserEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final user = await userRepository.registerUser(event.user);
      emit(UserRegistered(user));
    } catch (e) {
      emit(UserError("Error en el registro: $e"));
    }
  }

  Future<void> _onLoadUsers(
      LoadUsersEvent event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final users = await userRepository.fetchUsers();
      emit(UsersLoaded(users));
    } catch (e) {
      emit(UserError("Error cargando usuarios: $e"));
    }
  }
}
