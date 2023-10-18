import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_auth_example/local_auth_bloc/local_auth_bloc.dart';
import 'package:flutter_local_auth_example/screens/login_screen.dart';

class LocalAuthDemo extends StatelessWidget {
  const LocalAuthDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      LocalAuthBloc()..add(CheckDoesPhoneSupportLocalAuth()),
      lazy: false,
      child: MaterialApp(
        title: 'Local Auth Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
