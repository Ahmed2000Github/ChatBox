import 'package:chat_box/core/app_routes.dart';
import 'package:chat_box/core/app_theme.dart';
import 'package:chat_box/domain/entities/contact.dart';
import 'package:chat_box/presentation/viewmodels/search_contact.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

void setupLocator() {
  final GetIt getIt = GetIt.instance;
  getIt.registerLazySingleton<
          StateNotifierProvider<SearchContactViewModel, List<Contact>>>(
      () => StateNotifierProvider<SearchContactViewModel, List<Contact>>((ref) {
            return SearchContactViewModel();
          }));
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(const ChatBox());
}

class ChatBox extends StatelessWidget {
  const ChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ChatBox',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        onGenerateRoute: AppRoutes.generateRoute,
        initialRoute: AppRoutes.home,
      ),
    );
  }
}
