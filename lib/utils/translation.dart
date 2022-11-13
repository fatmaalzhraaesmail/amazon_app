import 'package:amazon_app/utils/ar.dart';
import 'package:amazon_app/utils/en.dart';
import 'package:get/get.dart';

class myTranslation extends Translations{
  @override
  Map<String, Map<String, String>> get keys => {
    'en':en,
    'ar':ar
  };

}