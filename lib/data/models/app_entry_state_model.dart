import 'package:chat_box/domain/entities/app_entry_state_entity.dart';

class AppEntryStateModel extends AppEntryStateEntity {
  const AppEntryStateModel(
      {required bool isLoggedIn, required bool isVerifyingEmail})
      : super(isLoggedIn: isLoggedIn, isVerifyingEmail: isVerifyingEmail);
}
