import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/features/auth/auth.dart';

@immutable
class AuthState extends Equatable {
  const AuthState({
    required this.authResult,
    required this.isLoading,
  });

  const AuthState.initial({
    this.authResult = AuthResult.none,
    this.isLoading = false,
  });

  final AuthResult authResult;
  final bool isLoading;

  @override
  List<Object> get props => [
        authResult,
        isLoading,
      ];

  @override
  bool get stringify => true;

  AuthState copyWith({
    AuthResult? authResult,
    bool? isLoading,
  }) {
    return AuthState(
      authResult: authResult ?? this.authResult,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
