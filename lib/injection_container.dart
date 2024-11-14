import 'package:chat_box/core/network/network_info.dart';
import 'package:chat_box/data/datasources/auth_remote_data_source_impl.dart';
import 'package:chat_box/data/datasources/interfaces/auth_remote_data_source.dart';
import 'package:chat_box/data/repositories/auth_repository_impl.dart';
import 'package:chat_box/domain/repositories/auth_repository.dart';
import 'package:chat_box/domain/usecases/authentication/get_user_infos_usecase.dart';
import 'package:chat_box/domain/usecases/authentication/google_auth_usecase.dart';
import 'package:chat_box/domain/usecases/authentication/logout_usecase.dart';
import 'package:chat_box/presentation/viewmodels/authentication/logout_view_model.dart';
import 'package:chat_box/presentation/viewmodels/authentication/sign_in_view_model.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/logout_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/sign_in_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/user_infos_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/user_infos_view_model.dart';
import 'package:chat_box/presentation/viewmodels/search_contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class InjectionContainer {
  final serviceLocator = GetIt.instance;

  static final InjectionContainer instance = InjectionContainer._internal();

  InjectionContainer._internal();

  factory InjectionContainer() => instance;

  Future<void> initialize() async {
// ViewModels

    serviceLocator.registerLazySingleton(() => SearchContactViewModel());
    serviceLocator.registerLazySingleton(() =>
        StateNotifierProvider<LogOutViewModel, LogOutState>(
            (ref) => LogOutViewModel(serviceLocator())));
    serviceLocator.registerLazySingleton(() =>
        StateNotifierProvider<UserInfosViewModel, UserInfosState>(
            (ref) => UserInfosViewModel(serviceLocator())));
    serviceLocator.registerLazySingleton(() =>
        StateNotifierProvider<SignInViewModel, SignInState>(
            (ref) => SignInViewModel(serviceLocator())));

// Usecases

    serviceLocator.registerLazySingleton(() => LogOutUseCase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => GetUserInfosUsecase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => GoogleAuthUseCase(serviceLocator()));

// Repository

    serviceLocator.registerLazySingleton<AuthRepository>(() =>
        AuthRepositoryImpl(
            networkInfo: serviceLocator(),
            authRemoteDataSource: serviceLocator()));

// Datasources

    serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl());

//! Core

    serviceLocator.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(serviceLocator()));

//! External

    serviceLocator.registerLazySingleton(() => InternetConnection());
  }
}
