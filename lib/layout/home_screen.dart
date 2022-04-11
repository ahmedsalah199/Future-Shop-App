import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/logic/shop_cubit/shop_cubit.dart';
import 'package:shop_app/presentation/modules/search_screen.dart';

import '../logic/shop_cubit/shop_state.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Future Shop',
              style: TextStyle(
                  color: Colors.pinkAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
            backgroundColor: Colors.grey[100],
            actions: [
              Padding(
                padding: const EdgeInsetsDirectional.only(end: 10.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) =>  SearchScreen()));
                    },
                    icon: const Icon(
                      Icons.search,
                      size: 30,
                    )),
              )
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              selectedItemColor: Colors.pinkAccent,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                cubit.changeBottomNavigation(index);
              },
              items: cubit.bottomNavigationBarItem),
        );
      },
    );
  }
}
