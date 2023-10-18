import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_auth_example/constants/enums.dart';
import 'package:flutter_local_auth_example/local_auth_bloc/local_auth_bloc.dart';
import 'package:flutter_local_auth_example/screens/home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Local Auth Demo'),
      ),
      body: BlocConsumer<LocalAuthBloc, LocalAuthState>(
        listener: (context, state) {
          if (state.status == Status.success && state.isAuthenticated) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          } else if (state.status == Status.failure && !state.isAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('User not verified'),
              ),
            );
          }
        },
        builder: (context, state) {
          if (!state.isLocalAuthSupported) {
            return const Center(
              child: Text('Sorry this device is not supported local auth'),
            );
          } else {
            return Center(
              child: ElevatedButton(
                onPressed: () => context
                    .read<LocalAuthBloc>()
                    .add(AuthenticateUserRequested()),
                child: const Text('Verify your self with local auth'),
              ),
            );
          }
        },
      ),
    );
  }
}
