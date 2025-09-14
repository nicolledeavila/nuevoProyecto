import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'data/register/register_api_provider.dart';
import 'data/register/register_repository.dart';
import 'data/profile/profile_api_provider.dart';
import 'data/profile/profile_repository.dart';

import 'logic/register/register_bloc.dart';
import 'logic/profile/profile_bloc.dart';

import 'presentation/screens/register_screen.dart';
import 'presentation/screens/profile_screen.dart';

void main() {
  final registerRepository = RegisterRepository(RegisterApiProvider());
  final profileRepository = ProfileRepository(ProfileApiProvider());

  runApp(MyApp(
    registerRepository: registerRepository,
    profileRepository: profileRepository,
  ));
}

class MyApp extends StatelessWidget {
  final RegisterRepository registerRepository;
  final ProfileRepository profileRepository;

  const MyApp({
    Key? key,
    required this.registerRepository,
    required this.profileRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => RegisterBloc(registerRepository)),
        BlocProvider(create: (_) => ProfileBloc(profileRepository)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Registro con Bloc',
        home: RegisterScreen(),
      ),
    );
  }
}
