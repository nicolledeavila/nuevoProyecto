import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Evento para cargar UN usuario
class LoadUserEvent extends ProfileEvent {}
