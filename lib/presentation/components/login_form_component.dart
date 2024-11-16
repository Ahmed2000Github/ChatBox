import 'package:chat_box/core/app_routes.dart';
import 'package:chat_box/domain/entities/sign_in_entity.dart';
import 'package:chat_box/presentation/components/custom_button.dart';
import 'package:chat_box/presentation/components/input_auth_field.dart';
import 'package:chat_box/presentation/viewmodels/authentication/sign_in_view_model.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/sign_in_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/user_infos_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/user_infos_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class LoginFormComponent extends StatefulWidget {
  final formKey;

  const LoginFormComponent({super.key, this.formKey});

  @override
  _LoginFormComponentState createState() => _LoginFormComponentState();
}

class _LoginFormComponentState extends State<LoginFormComponent> {
  late TextEditingController _emailTextEditingController;
  late TextEditingController _passwordTextEditingController;
  bool isEmailValid = true;
  bool isPasswordValid = true;

  @override
  void initState() {
    super.initState();
    _emailTextEditingController =
        TextEditingController(text: "ahmedelrhaouti2000@gmail.com");
    _passwordTextEditingController = TextEditingController(text: "12345678");
  }

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          InputAuthField(
            labelText: 'Your email',
            textEditingController: _emailTextEditingController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                isEmailValid = false;
                return "Invalid email address";
              }
              String pattern =
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
              RegExp regex = RegExp(pattern);
              if (!regex.hasMatch(value)) {
                isEmailValid = false;
                return 'Please enter a valid email address'; // Valid format
              }
              isEmailValid = true;
              return null;
            },
          ),
          const SizedBox(height: 20),
          InputAuthField(
            labelText: 'Password',
            textEditingController: _passwordTextEditingController,
            isPasswordField: true,
            obscureText: true,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                isPasswordValid = false;
                return "Invalid Password";
              }
              if (value.length < 8) {
                isPasswordValid = false;
                return "Password must be at least 8 characters";
              }
              isPasswordValid = true;
              return null;
            },
          ),
          SizedBox(height: 20),
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              final signInViewModel = GetIt.I<
                  StateNotifierProvider<SignInViewModel, SignInState>>();
              SignInState signInState = ref.watch(signInViewModel);
              signInState = (signInState is EmailAndPasswordSignInState)
                  ? signInState
                  : SignInState();
              if (signInState.isSuccess) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  final userInfosViewModel = GetIt.I<
                      StateNotifierProvider<UserInfosViewModel,
                          UserInfosState>>();
                  ref.watch(userInfosViewModel.notifier).load();
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.home, (route) => false);
                  ref.watch(signInViewModel.notifier).resetState();
                });
              }
              return Column(
                children: [
                  if (signInState.errorMessage != null)
                    Text(
                      signInState.errorMessage ?? '',
                      style: theme.textTheme.bodyLarge!.copyWith(
                        color: theme.colorScheme.error
                      ),
                    ),
                    SizedBox(height: 20),
                  Spacer(),
                  CustomButton(
                    onPressed: () {
                      print(isEmailValid);
                      print(isPasswordValid);
                      final isFormValid = isEmailValid && isPasswordValid;
                      if (!isFormValid) return;
                      final credentials = SignInEntity(
                          password: _passwordTextEditingController.text,
                          email: _emailTextEditingController.text);
                      ref.watch(signInViewModel.notifier).signIn(credentials);
                    },
                    text: "Log in",
                    isLoading: signInState.isLoading,
                  ),
                  Container(
                    height: 48,
                    child: Center(
                      child: Text(
                        "Forgot password?",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: theme.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}
