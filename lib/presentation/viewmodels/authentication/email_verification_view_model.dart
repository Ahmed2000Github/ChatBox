import 'dart:async';

import 'package:chat_box/domain/usecases/authentication/email_verification_use_case.dart';
import 'package:chat_box/domain/usecases/authentication/send_email_use_case.dart';
import 'package:chat_box/presentation/viewmodels/authentication/states/email_verification_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_box/core/extensions/either.dart';

class EmailVerificationViewModel extends StateNotifier<EmailVerificationState> {
  final EmailVerificationUseCase emailVerificationUseCase;
  final SendEmailUseCase sendEmailUseCase;

  EmailVerificationViewModel(
      this.emailVerificationUseCase, this.sendEmailUseCase)
      : super(EmailVerificationState());

  void verify() async {
    var result = await sendEmailUseCase();
    if (result.isRight()) {
      final result = await emailVerificationUseCase();

      state = result.toStateWithHandlers((result) {
        return EmailVerificationState(isSuccess: result);
      },
          (failure) =>
              EmailVerificationState(errorMessage: failure.getMessage()));
    } else {
      state = result.toStateWithDefault(
          EmailVerificationState(isSuccess: false),
          (failure) =>
              EmailVerificationState(errorMessage: failure.getMessage()));
    }
    print("ssssssssssssssssssssss");
    print(state.isSuccess);
  }

  void resetState() {
    state = EmailVerificationState();
  }
}
