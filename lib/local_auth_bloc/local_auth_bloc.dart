import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_auth_example/constants/enums.dart';
import 'package:local_auth/local_auth.dart';

part 'local_auth_event.dart';

part 'local_auth_state.dart';

class LocalAuthBloc extends Bloc<LocalAuthEvent, LocalAuthState> {
  LocalAuthBloc() : super(const LocalAuthState()) {
    on<CheckDoesPhoneSupportLocalAuth>(_onCheckDoesPhoneSupportLocalAuth);
    on<AuthenticateUserRequested>(_onAuthenticateUserRequested);
  }

  final LocalAuthentication _localAuthentication = LocalAuthentication();

  FutureOr<void> _onCheckDoesPhoneSupportLocalAuth(
    CheckDoesPhoneSupportLocalAuth event,
    Emitter<LocalAuthState> emit,
  ) async {
    emit(state.copyWith(status: Status.inProgress));
    bool isDeviceSupported = await _localAuthentication.isDeviceSupported();
    debugPrint('Local auth by device is supported == $isDeviceSupported');
    emit(
      state.copyWith(
        status: Status.success,
        isLocalAuthSupported: true,
      ),
    );
  }

  FutureOr<void> _onAuthenticateUserRequested(
    AuthenticateUserRequested event,
    Emitter<LocalAuthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: Status.inProgress));
      bool canCheckBioMetrics = await _localAuthentication.canCheckBiometrics;
      debugPrint('can check bio metric == $canCheckBioMetrics');
      var availableBiometrics =
          await _localAuthentication.getAvailableBiometrics();
      debugPrint('Available bio metrics == ${availableBiometrics.length}');
      var authenticated = await _localAuthentication.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      debugPrint('Authenticated == $authenticated');
      if (authenticated) {
        emit(
          state.copyWith(
            status: Status.success,
            isAuthenticated: authenticated,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: Status.failure,
            isAuthenticated: authenticated,
          ),
        );
      }
    } catch (e) {
      debugPrint(
          'Something went wrong while authenticating the user -- ${e.toString()}');
    }
  }
}
