import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/presentation/components/signup_form_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Signup extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  Signup({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap:()=> FocusScope.of(context).unfocus() ,
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraint) {
          return Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppConstants.horizontalPadding, vertical: 20),
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
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraint.maxHeight - 120),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Stack(
                                  children: [
                                     Positioned(
                                      top: 16,
                                      right: 0,
                                      child: 
                                    Container(
                                      height: 10,
                                      width: 48,
                                      color: AppConstants.barColor,
                                    )),
                                    Text(
                                      "Sign up with Email",
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
                              ],
                            ),
                            Expanded(
                                child: SignUpFormComponent(
                              formKey: _formKey,
                            )),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
