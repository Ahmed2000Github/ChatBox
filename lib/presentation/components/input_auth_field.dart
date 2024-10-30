import 'dart:math';

import 'package:flutter/material.dart';

class InputAuthField extends StatefulWidget {
  final TextEditingController? textEditingController;
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;

  InputAuthField(
      {super.key,
      this.textEditingController,
      this.labelText = "text",
      this.obscureText = false, this.validator});

  @override
  State<InputAuthField> createState() => _InputAuthFieldState();
}

class _InputAuthFieldState extends State<InputAuthField> {

  String? errorText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelStyle =
        theme.textTheme.headlineSmall!.copyWith(color: theme.primaryColor);
    return Column( // Align items to the right
      children: [
        const SizedBox(height: 15,),
        TextFormField(
          controller: widget.textEditingController,
          obscureText: widget.obscureText,
          obscuringCharacter : '⁕',
          cursorColor: errorText == null ? theme.primaryColor : theme.colorScheme.error,
          decoration: InputDecoration(
            labelText: widget.labelText,
            labelStyle: labelStyle,
            errorStyle: labelStyle,
            floatingLabelStyle: labelStyle.copyWith(
                color: errorText == null
                    ? theme.primaryColor
                    : theme.colorScheme.error),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: errorText == null? theme.primaryColor : Colors.transparent),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: errorText == null? Colors.grey:Colors.transparent),
            ),
          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {

            if (widget.validator != null) {
              final result = widget.validator!(value);
              WidgetsBinding.instance.addPostFrameCallback((_) {
                setState(() {
                  errorText = result;
                });
              });
            }
            return null;
          },
        ),
        Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Builder(
            builder: (context) {
              return errorText != null
                  ? Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(top: 5),
                    decoration:const BoxDecoration(
                      border: Border(top: BorderSide(
                        color: Colors.red,
                      ))
                    ),
                    child: Text(
                        errorText ?? "",
                        textAlign:
                            TextAlign.right, // Align error text to the right
                        style: theme.textTheme.bodyMedium!.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                  )
                  : const SizedBox.shrink(); // Empty space when there's no error
            },
          ),
        ),
      ],
    );
  }
}
