import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/register/register_repository.dart';
import '/data/models/user_model.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository;

  RegisterBloc(this.registerRepository) : super(RegisterInitial()) {
    on<RegisterUserEvent>(_onRegisterUser);
  }

  Future<void> _onRegisterUser(
      RegisterUserEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
      final UserModel registered = await registerRepository.registerUser(event.user);
      emit(RegisterSuccess(registered));
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }
}
