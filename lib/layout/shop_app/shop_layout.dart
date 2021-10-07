import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sala_shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:sala_shop_app/layout/shop_app/cubit/states.dart';
import 'package:sala_shop_app/modules/search/search_screen.dart';
import 'package:sala_shop_app/shared/components/custom_navigator.dart';

class HomePage extends StatelessWidget {
  static const String routeName = 'ShopHomeScreen';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('salla'),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  navigateToNamed(
                    context: context,
                    widget: SearchScreen.routeName,
                  );
                },
              )
            ],
          ),
          // backgroundColor: Colors.red,
          body: cubit.bottomNavScreen[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              cubit.changeBottomNavScreen(index);
            },
            currentIndex: cubit.currentIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category_sharp),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
        );
      },
    );
  }
}
