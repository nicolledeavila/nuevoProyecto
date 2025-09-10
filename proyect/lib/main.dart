import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/providers/api_provider.dart';
import 'data/repositories/user_repository.dart';
import 'logic/bloc/user_bloc.dart';
import 'presentation/screens/register_screen.dart';

void main() {
  final apiProvider = ApiProvider();
  final userRepository = UserRepository(apiProvider);

  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Registro con Bloc',
      home: BlocProvider(
        create: (_) => UserBloc(userRepository),
        child: RegisterScreen(),
      ),
    );
  }
}
