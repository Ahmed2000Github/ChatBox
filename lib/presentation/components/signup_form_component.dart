import 'package:chat_box/core/app_routes.dart';
import 'package:chat_box/domain/entities/authentication/sign_up_entity.dart';
import 'package:chat_box/presentation/components/custom_button.dart';
import 'package:chat_box/presentation/components/input_auth_field.dart';
import 'package:chat_box/presentation/viewmodels/authentication/email_verification_view_model.dart';
import 'package:chat_box/presentation/viewmodels/authentication/sign_up_view_model.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/email_verification_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class SignUpFormComponent extends StatefulWidget {
  final formKey;

  SignUpFormComponent({super.key, this.formKey});

  @override
  State<SignUpFormComponent> createState() => _SignUpFormComponentState();
}

class _SignUpFormComponentState extends State<SignUpFormComponent> {
  final TextEditingController _emailTextEditingController =
      TextEditingController(text: "ahmedelrhaouti2000@gmail.com");

  final TextEditingController _nameTextEditingController =
      TextEditingController(text: "Ahmed ELR");

  final TextEditingController _passwordTextEditingController =
      TextEditingController(text: "12345678");

  bool _isNameValid = true;
  bool _isEmailValid = true;
  bool _isPasswordValid = true;
  bool _isConfirmPasswordValid = true;
  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _nameTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: EdgeInsets.only(top: 40),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            InputAuthField(
              labelText: 'Your name',
              textEditingController: _emailTextEditingController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  _isNameValid = false;
                  return "Invalid name";
                }
                if (value.length < 4) {
                  _isNameValid = false;
                  return "Name must be at least 4 characters";
                }
                _isNameValid = true;
                return null;
              },
            ),
            const SizedBox(height: 10),
            InputAuthField(
              labelText: 'Your email',
              textEditingController: _nameTextEditingController,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  _isEmailValid = false;
                  return "Invalid email address";
                }
                String pattern =
                    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
                RegExp regex = RegExp(pattern);
                if (!regex.hasMatch(value)) {
                  _isEmailValid = false;
                  return 'Please enter a valid email address'; // Valid format
                }
                _isEmailValid = true;
                return null;
              },
            ),
            const SizedBox(height: 10),
            InputAuthField(
              labelText: 'Password',
              textEditingController: _passwordTextEditingController,
              obscureText: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  _isPasswordValid = false;
                  return "Invalid Password";
                }
                if (value.length < 8) {
                  _isPasswordValid = false;
                  return "Password must be at least 8 characters";
                }
                _isPasswordValid = true;
                return null;
              },
            ),
            const SizedBox(height: 10),
            InputAuthField(
              labelText: 'Confirm Password',
              textEditingController: _passwordTextEditingController,
              obscureText: true,
              validator: (value) {
                if (value == null ||
                    value.trim().isEmpty ||
                    _passwordTextEditingController.text != value) {
                  _isConfirmPasswordValid = false;
                  return "Passwords do not match";
                }
                _isConfirmPasswordValid = true;
                return null;
              },
            ),
            Expanded(child: Consumer(builder: (context, ref, child) {
              final signUpViewModel = GetIt.I<
                  StateNotifierProvider<SignUpViewModel, SignUpState>>();

              SignUpState signUpState = ref.watch(signUpViewModel);
              if (signUpState.isSuccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  final emailVerificationViewModel = GetIt.I<
                      StateNotifierProvider<EmailVerificationViewModel,
                          EmailVerificationState>>();
                  Navigator.pushNamed(context, AppRoutes.emailVerification);
                  ref.watch(emailVerificationViewModel.notifier).verify();
                  ref.watch(signUpViewModel.notifier).resetState();
                });
              }
              return Column(
                children: [
                  const SizedBox(height: 20),
                  if (signUpState.errorMessage != null)
                    Center(
                      child: Text(
                        signUpState.errorMessage ?? '',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge!
                            .copyWith(color: theme.colorScheme.error),
                      ),
                    ),
                  Spacer(),
                  const SizedBox(height: 10),
                  Consumer(builder: (context, ref, child) {
                    return CustomButton(
                      onPressed: () {
                        final isFormValid = _isNameValid &&
                            _isEmailValid &&
                            _isPasswordValid &&
                            _isConfirmPasswordValid;
                        if ((!isFormValid)) return;
                        final credentials = SignUpEntity(
                          password: _passwordTextEditingController.text,
                          email: _emailTextEditingController.text,
                          name: _nameTextEditingController.text,
                        );
                        ref.watch(signUpViewModel.notifier).signUp(credentials);
                      },
                      text: "Create an account",
                      isLoading: signUpState.isLoading,
                    );
                  }),
                ],
              );
            })),
          ],
        ),
      ),
    );
  }
}
