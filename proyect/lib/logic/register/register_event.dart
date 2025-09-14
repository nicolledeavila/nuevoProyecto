import 'package:equatable/equatable.dart';
import '/data/models/user_model.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterUserEvent extends RegisterEvent {
  final UserModel user;
  RegisterUserEvent(this.user);

  @override
  List<Object?> get props => [user];
}
