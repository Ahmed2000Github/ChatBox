import 'package:chat_box/presentation/components/custom_button.dart';
import 'package:chat_box/presentation/components/input_auth_field.dart';
import 'package:flutter/material.dart';

class LoginFormComponent extends StatelessWidget {
  final formKey ;

   TextEditingController _emailTextEditingController = TextEditingController(text: "");
   TextEditingController _passwordTextEditingController = TextEditingController(text: "");

  LoginFormComponent({super.key, this.formKey});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return    Form(
      key: formKey,
      child: Column(
        children: [
          InputAuthField(
            labelText: 'Your email',
            textEditingController: _emailTextEditingController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Invalid email address";
              }
              String pattern =
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
              RegExp regex = RegExp(pattern);
              if (!regex.hasMatch(value)) {
                return 'Please enter a valid email address'; // Valid format
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          InputAuthField(
            labelText: 'Password',
            textEditingController: _passwordTextEditingController,
            obscureText: true,
             validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return "Invalid Password";
              }
              if (value.length < 8) {
                return "Password must be at least 8 characters";
              }

              return null;
            },
          ),
           SizedBox(height: 20),
          Spacer(),
          Column(
            children: [
              CustomButton(text: "Log in"),
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
          ),
        ],
      ),
    );
  }
}
