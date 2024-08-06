import 'package:bridge_stone_tyre/views/full_screen_image.dart';
import 'package:bridge_stone_tyre/views/my_favourite_screen.dart';
import 'package:bridge_stone_tyre/views/select_country.dart';
import 'package:bridge_stone_tyre/views/select_model_screen.dart';
import 'package:bridge_stone_tyre/views/select_wheel_detail.dart';
import 'package:bridge_stone_tyre/views/select_wheel_type_screen.dart';
import 'package:get/get.dart';

import '../views/information_screen.dart';
import '../views/select_make_screen.dart';
import '../views/home_page.dart';
import '../views/terms_and_condition.dart';
import '../views/view_more_text.dart';

class AppRoutes {
  static const String home = '/';
  static const String selectMakeScreen = '/selectMakeScreen';
  static const String modelScreen = '/modelScreen';
  static const String wheelType = '/wheelType';
  static const String country = '/country';
  static const String selectWheelDetail = '/selectWheelDetail';
  static const String termsAndCondition = '/termsAndCondition';
  static const String viewFullScreen = '/viewFullScreen';
  static const String viewMoreText = '/viewMoreText';
  static const String myFavouriteScreen = '/myFavouriteScreen';
  static const String informationScreen = '/informationScreen';

  static final routes = [
    GetPage(name: home, page: () => const HomeScreen()),
    GetPage(name: selectMakeScreen, page: () => SelectMakeScreen()),
    GetPage(name: modelScreen, page: () => const SelectModelScreen()),
    GetPage(name: wheelType, page: () => const SelectWheelTypeScreen()),
    GetPage(name: country, page: () => const SelectCountry()),
    GetPage(name: selectWheelDetail, page: () => const SelectWheelDetailScreen()),
    GetPage(name: termsAndCondition, page: () => TermsAndCondition()),
    GetPage(name: viewFullScreen, page: () => const ViewFullScreen()),
    GetPage(name: myFavouriteScreen, page: () => const MyFavouriteScreen()),
    GetPage(name: informationScreen, page: () => InformationScreen()),
    GetPage(name: viewMoreText, page: () => ViewMoreText()),
  ];
}

