import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/profile/profile_repository.dart';
import '../../data/models/user_model.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;

  ProfileBloc(this.profileRepository) : super(ProfileInitial()) {
    on<LoadUserEvent>(_onLoadUser);
  }

  Future<void> _onLoadUser(
      LoadUserEvent event,
      Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final UserModel user = await profileRepository.fetchUser();
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError("Error cargando usuario: ${e.toString()}"));
    }
  }
}
