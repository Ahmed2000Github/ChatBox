import 'package:chat_box/core/strings/failures.dart';

abstract class Failure {
  String getMessage() {
    switch (runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case WeekPassFailure:
        return WEEK_PASS_FAILURE_MESSAGE;
      case ExistedAccountFailure:
        return EXISTED_ACCOUNT_FAILURE_MESSAGE;
      case NoUserFailure:
        return NO_USER_FAILURE_MESSAGE;
      case TooManyRequestsFailure:
        return TOO_MANY_REQUESTS_FAILURE_MESSAGE;
      case WrongPasswordFailure:
        return WRONG_PASSWORD_FAILURE_MESSAGE;
      case UnmatchedPassFailure:
        return UNMATCHED_PASSWORD_FAILURE_MESSAGE;
      case NotLoggedInFailure:
        return '';
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}

class OfflineFailure extends Failure {}

class ServerFailure extends Failure {}

class WeekPassFailure extends Failure {}

class ExistedAccountFailure extends Failure {}

class NoUserFailure extends Failure {}

class WrongPasswordFailure extends Failure {}

class UnmatchedPassFailure extends Failure {}

class NotLoggedInFailure extends Failure {}

class EmailVerifiedFailure extends Failure {}

class TooManyRequestsFailure extends Failure {}
class UnkownFailure extends Failure {}
