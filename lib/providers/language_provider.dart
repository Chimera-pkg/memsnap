import 'package:flutter/material.dart';
import 'package:learning_gamification/shared/widgets/snackbar_widget.dart';

class LanguageProvider extends ChangeNotifier {
  String? selectedLanguage;

  void setSelectedLanguage(BuildContext context, String lang) {
    selectedLanguage = lang;
    SnackbarWidget.show(
      context,
      message: 'Language changed to $lang',
      backgroundColor: Colors.green,
    );
    notifyListeners();
  }
}
