import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/user_model.dart';
import '../../logic/bloc/user_bloc.dart';
import '../../logic/bloc/user_event.dart';
import '../../logic/bloc/user_state.dart';
import 'profile_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Registro"),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserRegistered) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileScreen(user: state.user),
              ),
            );
          } else if (state is UserError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Ícono de usuario
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.deepPurple[200],
                        child: const Icon(Icons.person,
                            size: 50, color: Colors.white),
                      ),
                      const SizedBox(height: 20),

                      // Campo nombre
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Nombre",
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (v) =>
                            v!.isEmpty ? "Ingrese un nombre" : null,
                      ),
                      const SizedBox(height: 16),

                      // Campo email
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          prefixIcon: const Icon(Icons.email),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (v) =>
                            v!.isEmpty ? "Ingrese un correo" : null,
                      ),
                      const SizedBox(height: 16),

                      // Campo contraseña
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Contraseña",
                          prefixIcon: const Icon(Icons.lock),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        validator: (v) =>
                            v!.isEmpty ? "Ingrese una contraseña" : null,
                      ),
                      const SizedBox(height: 24),

                      // Botón de registro
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, state) {
                          if (state is UserLoading) {
                            return const CircularProgressIndicator();
                          }
                          return SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  final user = UserModel(
                                    name: _nameController.text,
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  );
                                  context
                                      .read<UserBloc>()
                                      .add(RegisterUserEvent(user));
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "Registrar",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
