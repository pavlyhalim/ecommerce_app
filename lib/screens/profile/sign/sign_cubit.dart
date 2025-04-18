import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_mall/screens/profile/sign/sign_state.dart';

class SignCubit extends Cubit<SignState> {
  SignCubit() : super(SignInitial()); // Use SignInitial() as the initial state.

  final signInPhoneController = TextEditingController();
  final signInPasswordController = TextEditingController();
  final signUpPhoneController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Sign In Logic
  void signIn(BuildContext context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: signInPhoneController.text + '@example.com', // يمكن استخدام رقم الهاتف كمثال للبريد الإلكتروني
          password: signInPasswordController.text,
        );

        emit(SignInSuccess());
      } on FirebaseAuthException catch (e) {
        emit(SignInFailed(e.message ?? "Error signing in"));
      }
    }
  }

  // Sign Up Logic
  void signUp(BuildContext context, GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      if (signUpPasswordController.text != confirmPasswordController.text) {
        emit(SignUpFailed("Passwords do not match"));
      } else {
        try {
          UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: signUpPhoneController.text + '@example.com', // يمكن استخدام رقم الهاتف كمثال للبريد الإلكتروني
            password: signUpPasswordController.text,
          );

          emit(SignUpSuccess());
        } on FirebaseAuthException catch (e) {
          emit(SignUpFailed(e.message ?? "Error signing up"));
        }
      }
    }
  }

  @override
  Future<void> close() {
    // dispose controllers
    signInPhoneController.dispose();
    signInPasswordController.dispose();
    signUpPhoneController.dispose();
    signUpPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
