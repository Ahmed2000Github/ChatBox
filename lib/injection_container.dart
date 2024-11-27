import 'package:chat_box/core/network/network_info.dart';
import 'package:chat_box/data/datasources/auth_remote_data_source_impl.dart';
import 'package:chat_box/data/datasources/interfaces/auth_remote_data_source.dart';
import 'package:chat_box/data/datasources/interfaces/story_remote_data_source.dart';
import 'package:chat_box/data/datasources/story_remote_data_source_impl.dart';
import 'package:chat_box/data/repositories/auth_repository_impl.dart';
import 'package:chat_box/data/repositories/story_repository_impl.dart';
import 'package:chat_box/domain/entities/contact.dart';
import 'package:chat_box/domain/repositories/auth_repository.dart';
import 'package:chat_box/domain/repositories/story_repository.dart';
import 'package:chat_box/domain/usecases/authentication/app_initialization_usecase.dart';
import 'package:chat_box/domain/usecases/authentication/email_auth_usecase.dart';
import 'package:chat_box/domain/usecases/authentication/email_verification_use_case.dart';
import 'package:chat_box/domain/usecases/authentication/facebook_auth_usecase.dart';
import 'package:chat_box/domain/usecases/authentication/get_user_infos_usecase.dart';
import 'package:chat_box/domain/usecases/authentication/google_auth_usecase.dart';
import 'package:chat_box/domain/usecases/authentication/logout_usecase.dart';
import 'package:chat_box/domain/usecases/authentication/send_email_use_case.dart';
import 'package:chat_box/domain/usecases/authentication/sign_up_usecase.dart';
import 'package:chat_box/domain/usecases/stories/create_story_usecase.dart';
import 'package:chat_box/domain/usecases/stories/get_stories_usecase.dart';
import 'package:chat_box/presentation/viewmodels/authentication/app_initialization_view_model.dart';
import 'package:chat_box/presentation/viewmodels/authentication/email_verification_view_model.dart';
import 'package:chat_box/presentation/viewmodels/authentication/logout_view_model.dart';
import 'package:chat_box/presentation/viewmodels/authentication/sign_in_view_model.dart';
import 'package:chat_box/presentation/viewmodels/authentication/sign_up_view_model.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/app_initialization_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/email_verification_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/logout_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/sign_in_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/sign_up_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/user_infos_state.dart';
import 'package:chat_box/presentation/viewmodels/authentication/user_infos_view_model.dart';
import 'package:chat_box/presentation/viewmodels/search_contact.dart';
import 'package:chat_box/presentation/viewmodels/stories/states/create_story_state.dart';
import 'package:chat_box/presentation/viewmodels/stories/states/story_state.dart';
import 'package:chat_box/presentation/viewmodels/stories/create_story_view_model.dart';
import 'package:chat_box/presentation/viewmodels/stories/story_view_model.dart';
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

    registerStateNotifierProvider<CreateStoryViewModel, CreateStoryState>(
        (ref) => CreateStoryViewModel(serviceLocator()));
    registerStateNotifierProvider<StoryViewModel, StoryState>(
        (ref) => StoryViewModel(serviceLocator()));

    registerStateNotifierProvider<EmailVerificationViewModel,
            EmailVerificationState>(
        (ref) =>
            EmailVerificationViewModel(serviceLocator(), serviceLocator()));

    registerStateNotifierProvider<AppInitializationViewModel,
            AppInitializationState>(
        (ref) => AppInitializationViewModel(serviceLocator()));
        
    registerStateNotifierProvider<SearchContactViewModel, List<Contact>>(
        (ref) => SearchContactViewModel());
    registerStateNotifierProvider<LogOutViewModel, LogOutState>(
        (ref) => LogOutViewModel(serviceLocator()));

    registerStateNotifierProvider<SignUpViewModel, SignUpState>(
        (ref) => SignUpViewModel(serviceLocator()));

    registerStateNotifierProvider<UserInfosViewModel, UserInfosState>(
        (ref) => UserInfosViewModel(serviceLocator()));

    registerStateNotifierProvider<SignInViewModel, SignInState>((ref) =>
        SignInViewModel(serviceLocator(), serviceLocator(), serviceLocator()));

// Usecases

    serviceLocator.registerLazySingleton(() => LogOutUseCase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => GetStoriesUsecase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => CreateStoryUsecase(serviceLocator()));
    serviceLocator.registerLazySingleton(
        () => AppInitializationUsecase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => SendEmailUseCase(serviceLocator()));
    serviceLocator.registerLazySingleton(
        () => EmailVerificationUseCase(serviceLocator()));
    serviceLocator.registerLazySingleton(() => SignUpUsecase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => EmailAuthUsecase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => FacebookAuthUsecase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => GetUserInfosUsecase(serviceLocator()));
    serviceLocator
        .registerLazySingleton(() => GoogleAuthUseCase(serviceLocator()));

// Repository

    serviceLocator.registerLazySingleton<AuthRepository>(() =>
        AuthRepositoryImpl(
            networkInfo: serviceLocator(),
            authRemoteDataSource: serviceLocator()));
    serviceLocator.registerLazySingleton<StoryRepository>(() =>
        StoryRepositoryImpl(
            networkInfo: serviceLocator(),
            storyRemoteDataSource: serviceLocator()));

// Datasources

    serviceLocator.registerLazySingleton<AuthRemoteDataSource>(
        () => AuthRemoteDataSourceImpl());
    serviceLocator.registerLazySingleton<StoryRemoteDataSource>(
        () => StoryRemoteDataSourceImpl());

//! Core

    serviceLocator.registerLazySingleton<NetworkInfo>(
        () => NetworkInfoImpl(serviceLocator()));

//! External

    serviceLocator.registerLazySingleton(() => InternetConnection());
  }

  void registerStateNotifierProvider<T extends StateNotifier<S>, S>(
      T Function(Ref ref) viewModelFactory) {
    serviceLocator.registerLazySingleton(
        () => StateNotifierProvider<T, S>(viewModelFactory));
  }
}
