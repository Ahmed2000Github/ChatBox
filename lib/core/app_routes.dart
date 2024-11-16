import 'package:chat_box/presentation/views/conversation.dart';
import 'package:chat_box/presentation/views/email_verification.dart';
import 'package:chat_box/presentation/views/home.dart';
import 'package:chat_box/presentation/views/initial.dart';
import 'package:chat_box/presentation/views/login.dart';
import 'package:chat_box/presentation/views/not_found.dart';
import 'package:chat_box/presentation/views/search_contact.dart';
import 'package:chat_box/presentation/views/signup.dart';
import 'package:chat_box/presentation/views/video_call.dart';
import 'package:chat_box/presentation/views/voice_call.dart';
import 'package:chat_box/presentation/views/welcome.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String welcome = '/welcome';
  static const String initial = '/initial';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String emailVerification = '/emailVerification';
  static const String home = '/home';
  static const String conversation = '/conversation';
  static const String voiceCall = '/voiceCall';
  static const String videoCall = '/videoCall';
  static const String searchContact = '/searchContact';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Widget page;
    bool isLeftSliding = false;
    switch (settings.name) {
      case welcome:
        isLeftSliding = true;
        page = const Welcome();
        break;
      case initial:
        page = const Initial();
        break;
      case login:
        page = Login();
        break;
      case signup:
        page = Signup();
        break;
      case emailVerification:
        page = EmailVerification();
        break;
      case home:
        page = Home();
        break;
      case conversation:
        page = Conversation();
        break;
      case searchContact:
        page = SearchContact();
        break;
      case voiceCall:
        final isExternalCaller = settings.arguments as bool;
        page = VoiceCall(
          isExternalCaller: isExternalCaller,
        );
        break;
      case videoCall:
        final isExternalCaller = settings.arguments as bool;
        page = VideoCall(
          isExternalCaller: isExternalCaller,
        );
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
        final begin =
            isLeftSliding ? const Offset(-1.0, 0.0) : const Offset(1.0, 0.0);
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
