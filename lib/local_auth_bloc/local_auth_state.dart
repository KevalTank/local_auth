part of 'local_auth_bloc.dart';

class LocalAuthState extends Equatable {
  const LocalAuthState({
    this.status = Status.initial,
    this.errorMessage = '',
    this.isLocalAuthSupported = false,
    this.isAuthenticated = false,
  });

  final Status status;
  final String errorMessage;
  final bool isLocalAuthSupported;
  final bool isAuthenticated;

  LocalAuthState copyWith({
    Status? status,
    String? errorMessage,
    bool? isLocalAuthSupported,
    bool? isAuthenticated,
  }) {
    return LocalAuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      isLocalAuthSupported: isLocalAuthSupported ?? this.isLocalAuthSupported,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
    );
  }

  @override
  List<Object> get props => [
        status,
        errorMessage,
        isLocalAuthSupported,
        isAuthenticated,
      ];
}
