import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/presentation/components/external_auth_component.dart';
import 'package:chat_box/presentation/components/input_auth_field.dart';
import 'package:chat_box/presentation/components/login_form_component.dart';
import 'package:chat_box/presentation/components/text_divider_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraint) {
          return Padding(
                  padding:
            EdgeInsets.symmetric(horizontal: AppConstants.horizontalPadding,vertical: 20),
                  child: Column(
          children: [
            Container(
                alignment: Alignment.centerLeft,
                height: 48,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: SvgPicture.asset(
                      "${AppConstants.iconsPath}arrow-back.svg",
                      width: 24,
                      color: theme.textTheme.bodySmall!.color!,
                    ))),
            Expanded(
              child: SingleChildScrollView(
                child:  ConstrainedBox(
                      constraints: BoxConstraints(minHeight: constraint.maxHeight-100),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        Column(
                          children: [
                         Stack(
                                children: [
                                  Positioned(
                                      top: 10,
                                      child: Container(
                                        height: 10,
                                        width: 65,
                                        color: AppConstants.barColor,
                                      )),
                                  Text(
                                    "Log in to Chatbox",
                                    style:
                                        theme.textTheme.headlineSmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                        const SizedBox(
                          height: 15,
                        ),
                        Opacity(
                          opacity: .7,
                          child: Text(
                            "Welcome back! Sign in using your socia",
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Opacity(
                          opacity: .7,
                          child: Text(
                            "account or email to continue us",
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        const ExternalAuthComponent(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextDivider(text: "or"),
                        ),
                          ],
                        ),
                        Expanded(child: LoginFormComponent(formKey: _formKey,)), 
                     ],
                    ),
                  ),
                ),
              ),
            ),
          ],
                  ),
                );
        }
      ),
    );
  }
}
