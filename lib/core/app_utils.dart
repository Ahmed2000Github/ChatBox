import 'package:chat_box/core/app_constants.dart';
import 'package:flutter/material.dart';

class AppUtils {
  static String getImagePath(BuildContext context, String name,{String extension="svg"}) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return  "${AppConstants.imagesPath}$name-${isDarkMode ? "dark" : "light"}.$extension";
  }
  static String getIconPath(BuildContext context, String name,
      {String extension = "svg"}) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return "${AppConstants.iconsPath}$name-${isDarkMode ? "dark" : "light"}.$extension";
  }
}
