import 'package:equatable/equatable.dart';
import '../../data/models/user_model.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// 👉 Evento para registrar un usuario
class RegisterUserEvent extends UserEvent {
  final UserModel user;

  RegisterUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}

// 👉 Evento para cargar la lista de usuarios
class LoadUsersEvent extends UserEvent {}
