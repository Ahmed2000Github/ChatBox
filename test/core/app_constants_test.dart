
import 'package:chat_box/core/app_constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AppConstants.iconsPath should be the correct path', () {
    const expectedPath = "assets/icons/";
    expect(AppConstants.iconsPath, expectedPath);
  });
  test('AppConstants.imagesPath should be the correct URL', () {
    const expectedPath = "assets/images/";
    expect(AppConstants.imagesPath, expectedPath);
  });

}
