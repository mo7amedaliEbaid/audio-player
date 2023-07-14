import 'dart:async';

//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'data_provider.dart';
part 'state.dart';

class AuthCubit extends Cubit<AuthState> {
  static AuthCubit cubit(BuildContext context, [bool listen = false]) =>
      BlocProvider.of<AuthCubit>(context, listen: listen);

  AuthCubit() : super(AuthDefault());

  Future<void> login(String email, String password) async {
    emit(const AuthLoginLoading());
    try {
      final data = await AuthDataProvider.login(email, password);
      emit(AuthLoginSuccess(data: data));
    } catch (e) {
      emit(AuthLoginFailed(message: e.toString()));
    }
  }

  Future<void> logout() async {
    emit(const AuthLogoutLoading());

    try {
      await AuthDataProvider.logout();
      emit(const AuthLogoutSuccess());
    } catch (e) {
      emit(AuthLogoutFailed(message: e.toString()));
    }
  }

  Future<void> signup(String fullName, String email, String password) async {
    emit(const AuthSignUpLoading());
    try {
      final data = await AuthDataProvider.signUp(fullName, email, password);

      emit(AuthSignUpSuccess(data: data));
    } catch (e) {
      emit(AuthSignUpFailed(message: e.toString()));
    }
  }

  Future<void> gmailLogin() async {
    emit(const GmailLoginLoading());
    try {
      final data = await AuthDataProvider.googleSignIn();

      if (data == null) {
        emit(const GmailLoginFailed(message: 'Gmail login cancelled'));
      } else {
        emit(GmailLoginSuccess(data: data));
      }
    } catch (e) {
      emit(
        GmailLoginFailed(message: e.toString()),
      );
    }
  }

/*  Future<void> facebookLogin() async {
    emit(const FBLoginLoading());
    try {
      final data = await AuthDataProvider.facebookSignIn();

      if (data == null) {
        emit(const FBLoginFailed(message: 'Facebook login cancelled'));
      } else {
        emit(FBLoginSuccess(data: data));
      }
    } catch (e) {
      emit(FBLoginFailed(message: e.toString()));
    }
  }*/

  Future<void> forgotPassword(String email) async {
    emit(const AuthForgotPasswordLoading());

    try {
      await AuthDataProvider.forgotPassword(email);
      emit(const AuthForgotPasswordSuccess());
    } catch (e) {
      emit(AuthForgotPasswordFailed(message: e.toString()));
    }
  }
}
