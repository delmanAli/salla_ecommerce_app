import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sala_shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:sala_shop_app/layout/shop_app/shop_layout.dart';
import 'package:sala_shop_app/modules/categories/categories_screen.dart';
import 'package:sala_shop_app/modules/login/login_screen.dart';
import 'package:sala_shop_app/modules/on_boarding/on_boarding_screen.dart';
import 'package:sala_shop_app/modules/products/products_screen.dart';
import 'package:sala_shop_app/modules/register/register_screen.dart';
import 'package:sala_shop_app/modules/search/search_screen.dart';
import 'package:sala_shop_app/shared/bloc_observer.dart';
import 'package:sala_shop_app/shared/components/constant.dart';
import 'package:sala_shop_app/shared/network/remote/dio_helper.dart';
import 'package:sala_shop_app/shared/styles/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();

  DioHelper.init();

  print(token);
  // token = CacheHelper.getData(key: 'token');
  // await CacheHelper.init();

  // var userData = CacheHelper.getData(
  //   key: 'userData',
  // );

  // UserModal.fromJson(jsonDecode(userData));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => ShopCubit()
            ..getHomeData()
            ..getCategories()
            ..getFavorites()
            ..getUserProfile(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'sella',
        theme: lightThemes,
        // darkTheme: darkThemes,
        // initialRoute: HomePage.routeName,
        // initialRoute: LoginScreen.routeName,
        initialRoute: OnBoardingScreen.routeName,
        routes: {
          OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
          LoginScreen.routeName: (context) => LoginScreen(),
          RegisterScreen.routeName: (context) => RegisterScreen(),
          HomePage.routeName: (context) => HomePage(),
          ProductsScreen.routeName: (context) => ProductsScreen(),
          SearchScreen.routeName: (context) => SearchScreen(),
          CategoriesScreen.routeName: (context) => CategoriesScreen(),
        },
      ),
    );
  }
}
