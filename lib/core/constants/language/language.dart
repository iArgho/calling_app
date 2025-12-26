import 'package:template_getx/core/constants/language/data/language_bangla_data.dart';
import 'package:template_getx/core/constants/language/data/language_english_data.dart';
import 'package:get/get_navigation/src/root/internacionalization.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': languageEnglishData,
    'bn_BD': languageBanglaData,
  };
}
