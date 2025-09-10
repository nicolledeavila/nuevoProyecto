import 'package:equatable/equatable.dart';
import '../../data/models/user_model.dart';

abstract class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

// Estado inicial
class UserInitial extends UserState {}

// Estado cargando
class UserLoading extends UserState {}

// Estado cuando un usuario se registró correctamente
class UserRegistered extends UserState {
  final UserModel user;

  UserRegistered(this.user);

  @override
  List<Object?> get props => [user];
}

// Estado cuando se cargaron los usuarios
class UsersLoaded extends UserState {
  final List<UserModel> users;

  UsersLoaded(this.users);

  @override
  List<Object?> get props => [users];
}

// Estado de error
class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object?> get props => [message];
}
