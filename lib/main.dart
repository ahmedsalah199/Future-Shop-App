import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/web_services/dio_helper.dart';
import 'package:shop_app/layout/home_screen.dart';
import 'package:shop_app/logic/shop_cubit/shop_cubit.dart';
import 'package:shop_app/presentation/modules/login_screen.dart';
import 'package:shop_app/presentation/modules/on_boarding_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/local/shared_preferences.dart';
import 'package:shop_app/shared/observer_bloc.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  await DioHelper.initDio();
  await SharedPreferencesData.init();
  var onBoarding = SharedPreferencesData.getData(key: 'onBoarding');
  token = SharedPreferencesData.getData(key: 'token');
  Widget widget;
  if (onBoarding != null) {
    if (token != null) {
      widget = const HomeScreen();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }
  BlocOverrides.runZoned(
        () {
      runApp(MyApp(
        widget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final Widget widget;

  const MyApp({Key? key, required this.widget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()..getHomeData()..getCategories()..getFavourite()..getProfile(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 0.0,
              iconTheme: IconThemeData(
                  color: Colors.black
              )
          ),
        ),
        home: widget,
      ),
    );
  }
}

