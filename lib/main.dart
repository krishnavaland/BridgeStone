
import 'package:bridge_stone_tyre/model/get_country_list_model.dart';
import 'package:bridge_stone_tyre/model/get_favourite_model.dart';
import 'package:bridge_stone_tyre/model/get_wheel_type_detail_model.dart';
import 'package:bridge_stone_tyre/model/select_model_by_id_model.dart';
import 'package:bridge_stone_tyre/model/select_wheel_type_model.dart';
import 'package:bridge_stone_tyre/model/vehicle_category_model.dart';
import 'package:bridge_stone_tyre/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constant/theme_constant.dart';
import 'dependency_injector.dart';
import 'model/select_make_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  DependencyInjector.initializeController();
  final pref = await SharedPreferences.getInstance();
  bool isFirst = pref.getBool('isFirstLaunch') ?? true;

  await Hive.initFlutter();
  Hive.registerAdapter(SelectMakeModelAdapter());
  Hive.registerAdapter(MakeDataAdapter());
  Hive.registerAdapter(GetCountryListModelAdapter());
  Hive.registerAdapter(CountryDataAdapter());
  Hive.registerAdapter(SelectModelByIdModelAdapter());
  Hive.registerAdapter(VehicleModelDataAdapter());
  Hive.registerAdapter(SelectWheelTypeModelAdapter());
  Hive.registerAdapter(WheelDataAdapter());
  Hive.registerAdapter(ModelIdAdapter());
  Hive.registerAdapter(SelectVehicleCategoryModelAdapter());
  Hive.registerAdapter(CategoryDataAdapter());
  Hive.registerAdapter(GetWheelTypeDetailModelAdapter());
  Hive.registerAdapter(WheelDetailDataAdapter());
  Hive.registerAdapter(WheelDetailModelIdAdapter());
  Hive.registerAdapter(MakeMasterAdapter());
  Hive.registerAdapter(GetFavouriteModelAdapter());
  Hive.registerAdapter(GetFavDataAdapter());
  Hive.registerAdapter(FavouriteDataAdapter());
  await Hive.openBox<GetCountryListModel>('getCountryListModel');
  await Hive.openBox<GetFavouriteModel>('getFavouriteModel');
  await Hive.openBox<SelectVehicleCategoryModel>('selectVehicleCategoryModel');
  await Hive.openBox<Map<dynamic,dynamic>>('selectMakeModel');
  await Hive.openBox<Map<dynamic,dynamic>>('selectModelByIdModel');
  await Hive.openBox<Map<dynamic,dynamic>>('selectWheelTypeModel');
  await Hive.openBox<Map<dynamic,dynamic>>('getWheelTypeDetailModel');

  runApp(MyApp(isFirstTime: isFirst));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isFirstTime});

  final bool isFirstTime;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vaculus',
      theme: themeData,
      initialRoute: isFirstTime ? AppRoutes.termsAndCondition : AppRoutes.home,
      getPages: AppRoutes.routes,
    );
  }
}
