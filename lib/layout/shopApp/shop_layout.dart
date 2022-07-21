import 'package:flutter/material.dart';
import 'package:flutter_application_2/layout/shopApp/cubit/cubit.dart';
import 'package:flutter_application_2/layout/shopApp/cubit/states.dart';
import 'package:flutter_application_2/modules/shop_app/search/search_screen.dart';
import 'package:flutter_application_2/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
        value: BlocProvider.of<ShopCubit>(context)
          ..getHomeData()
          ..getCategoriesData()
          ..getFavorites()
          ..getProfile(),
        child: BlocConsumer<ShopCubit, ShopStates>(
          listener: (context, state) {},
          builder: (context, state) {
            ShopCubit shopCubit = ShopCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Text('Sala'),
                actions: [
                  IconButton(
                    onPressed: () {
                      navigateTo(context, SearchScreen());
                    },
                    icon: Icon(Icons.search),
                  ),
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.apps,
                    ),
                    label: 'Categories',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'Favorites',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'settings',
                  ),
                ],
                currentIndex: shopCubit.currentIndex,
                onTap: (index) {
                  shopCubit.changeIndex(index);
                },
              ),
              body: shopCubit.screen[shopCubit.currentIndex],
            );
          },
        ));
  }
}
