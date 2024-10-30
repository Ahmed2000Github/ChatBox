import 'package:chat_box/presentation/components/custom_button.dart';
import 'package:chat_box/presentation/components/input_auth_field.dart';
import 'package:flutter/material.dart';

class SignUpFormComponent extends StatefulWidget {
  final formKey ;


  SignUpFormComponent({super.key, this.formKey});

  @override
  State<SignUpFormComponent> createState() => _SignUpFormComponentState();
}

class _SignUpFormComponentState extends State<SignUpFormComponent> {
   final TextEditingController _emailTextEditingController = TextEditingController(text: "");

   final TextEditingController _nameTextEditingController = TextEditingController(text: "");

   final TextEditingController _passwordTextEditingController = TextEditingController(text: "");
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
    return    Container(
      margin: EdgeInsets.only(top: 40),
      child: Form(
        key: widget.formKey,
        child: Column(
          children: [
            InputAuthField(
              labelText: 'Your name',
              textEditingController: _emailTextEditingController,
              validator: (value){
                if (value == null || value.trim().isEmpty) {
                  return "Invalid name";
                }
                if (value.length < 4) {
                  return "Name must be at least 4 characters";
                }
              
                return null;
              },
            ),
            const SizedBox(height: 10),
            InputAuthField(
              labelText: 'Your email',
              textEditingController: _nameTextEditingController,
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
            const SizedBox(height: 10),
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
            const SizedBox(height: 10),
            InputAuthField(
              labelText: 'Confirm Password',
              obscureText: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty||
                    _passwordTextEditingController.text !=value) {
                  return "Passwords do not match";
                }
                return null;
              },
            ),
            Spacer(),
            const SizedBox(height: 10),
                CustomButton(text: "Create an account"),
            
          ],
        ),
      ),
    );
  }
}
