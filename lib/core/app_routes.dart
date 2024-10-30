import 'package:chat_box/presentation/views/conversation.dart';
import 'package:chat_box/presentation/views/home.dart';
import 'package:chat_box/presentation/views/login.dart';
import 'package:chat_box/presentation/views/not_found.dart';
import 'package:chat_box/presentation/views/signup.dart';
import 'package:chat_box/presentation/views/welcome.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String conversation = '/conversation';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;
    bool isLeftSliding = false;
    switch (settings.name) {
      case welcome:
        page = const Welcome();
        break;
      case login:
        page =  Login();
        break;
      case signup:
        page =  Signup();
        break;
      case home:
        page =  Home();
        break;
      case conversation:
        page =  Conversation();
        break;
      default:
        page = const NotFound();
    }
    return PageRouteBuilder(
      transitionDuration: const Duration(milliseconds: 500),
      pageBuilder: (context, animation, secondaryAnimation) {
        return page;
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final begin = isLeftSliding ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);
        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
