import 'package:chat_box/core/app_constants.dart';
import 'package:chat_box/core/app_routes.dart';
import 'package:chat_box/core/app_utils.dart';
import 'package:chat_box/presentation/components/external_auth_component.dart';
import 'package:chat_box/presentation/components/text_divider_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.displayLarge?.color;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              child: Image.asset(
                          AppUtils.getImagePath(context, "ellipse-blur", extension: "png"),
                          width: width,
                          fit: BoxFit.fill,
                        )),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: AppConstants.horizontalPadding),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SvgPicture.asset(
                    "assets/images/inline-chatbox.svg",
                    colorFilter: ColorFilter.mode(
                        textColor ?? Colors.red, BlendMode.srcIn),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                       width: 2*width / 3,
                      child: Text(
                        "Connect friends easily & quickly",
                        style: theme.textTheme.headlineLarge,
                      ),
                    )),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Opacity(
                      opacity: 0.7,
                      child: Text(
                        "Our chat app is the perfect way to stay connected with friends and family.",
                        style: theme.textTheme.bodyLarge,
                      ),
                    )),
                    const ExternalAuthComponent(),
              TextDivider(text: "or"),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: AppConstants.buttonHeight,
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                        color: theme.textTheme.bodySmall!.color,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Sign up with an email",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.scaffoldBackgroundColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Existing account?",
                          style: theme.textTheme.bodySmall),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, AppRoutes.login);
                        },
                        child: Text(
                          " Log in",
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
