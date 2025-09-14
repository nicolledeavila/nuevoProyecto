import 'package:equatable/equatable.dart';
import 'package:proyect/data/models/user_model.dart'; // 👈 asegúrate que apunte al archivo correcto

abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final UserModel user;
  RegisterSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class RegisterError extends RegisterState {
  final String message;
  RegisterError(this.message);

  @override
  List<Object?> get props => [message];
}

