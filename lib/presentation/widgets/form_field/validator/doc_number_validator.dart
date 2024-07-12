import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';

class DocNumberValidator {
  static String? validate(String? value) {
    final clearedValue = value?.trim().clearCharacters();
    if (clearedValue == null || clearedValue.isEmpty) {
      return Strings.commonErrorFieldIsRequired;
    }

    if (!RegExp(r'^\d{7}$').hasMatch(clearedValue)) {
      return Strings.commonErrorDocNumberNotValid;
    }

    return null;
  }
}