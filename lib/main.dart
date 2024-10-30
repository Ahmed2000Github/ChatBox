import 'package:chat_box/core/app_routes.dart';
import 'package:chat_box/core/app_theme.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ChatBox());
}

class ChatBox extends StatelessWidget {
  const ChatBox({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatBox',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.home,
    );
  }
}
