import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:wehavit/domain/entities/entities.dart';

@immutable
class AuthState extends Equatable {
  const AuthState({
    required this.authResult,
    required this.isLoading,
    required this.authType,
  });

  const AuthState.initial({
    this.authResult = AuthResult.none,
    this.isLoading = false,
    this.authType = AuthType.google,
  });

  final AuthResult authResult;
  final AuthType authType;
  final bool isLoading;

  @override
  List<Object> get props => [
        authResult,
        isLoading,
        authType,
      ];

  @override
  bool get stringify => true;

  AuthState copyWith({
    AuthResult? authResult,
    bool? isLoading,
    AuthType? authType,
  }) {
    return AuthState(
      authResult: authResult ?? this.authResult,
      isLoading: isLoading ?? this.isLoading,
      authType: authType ?? this.authType,
    );
  }
}

enum AuthType { google, emailAndPassword, none }
