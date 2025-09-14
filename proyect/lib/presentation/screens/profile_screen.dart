import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user_model.dart';
import '../../logic/profile/profile_bloc.dart';
import '../../logic/profile/profile_event.dart';
import '../../logic/profile/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  final UserModel user;
  const ProfileScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // esto es para q se carge el user cuando inicie
    context.read<ProfileBloc>().add(LoadUserEvent());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Perfil"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ProfileLoaded) {
            final profileUser = state.user;
            return _buildProfile(context, profileUser);
          } else if (state is ProfileError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            // Estado inicial: mostrar el usuario recibido desde Register
            return _buildProfile(context, user);
          }
        },
      ),
    );
  }

  Widget _buildProfile(BuildContext context, UserModel user) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 6,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.deepPurple[200],
                  child: const Icon(Icons.person,
                      size: 60, color: Colors.white),
                ),
                Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwlxL_1sv3ljDz7FC2wQM8MdGWReBIoseZOw&s"),
                const SizedBox(height: 20),
                Text(
                  user.name,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.email,
                        color: Colors.grey, size: 20),
                    const SizedBox(width: 6),
                    Text(
                      user.email,
                      style: const TextStyle(
                          fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}