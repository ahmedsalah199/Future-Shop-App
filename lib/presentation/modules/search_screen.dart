import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/model/search_model.dart';
import 'package:shop_app/logic/search_cubit/search_cubit.dart';
import 'package:shop_app/logic/search_cubit/search_state.dart';
import 'package:shop_app/logic/shop_cubit/shop_state.dart';
import 'package:shop_app/shared/components/components.dart';

import '../../logic/shop_cubit/shop_cubit.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          var search = SearchCubit.getCubit(context).searchModel;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.grey[100],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  defaultTextForm(
                    controller: searchController,
                    keyboardType: TextInputType.text,
                    label: 'Search',
                    onChanged: (text) {
                        SearchCubit.getCubit(context).getSearch(text: text);
                    },
                    prefixIcon: Icons.search,
                    validate: (value) {
                      if (value!.isEmpty) {
                        return 'Search Can\'t be empty';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 20
                  ),
                  if(state is SearchLoadingState)
                    const Center(child: CircularProgressIndicator()),
                  if ( state is SearchSuccessState && search != null )
                    Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) => buildSearchScreen(
                                search.data!.data[index], context),
                            itemCount: search.data!.data.length,
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildSearchScreen(DataSearch model, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                FadeInImage.assetNetwork(
                  image: model.image.toString(),
                  height: 150,
                  width: 150,
                  placeholder: 'assets/images/loading.gif',
                ),
                const SizedBox(
                  width: 6,
                ),
                Expanded(
                  child: Text(
                    model.name.toString(),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "\$ ${model.price!.round()}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.blue),
                ),
                BlocConsumer<ShopCubit, ShopState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    return IconButton(
                      onPressed: () {
                        ShopCubit.get(context)
                            .changeFavourite(productId: model.id);
                      },
                      iconSize: 30,
                      icon: ShopCubit.get(context).listFavourite![model.id] ==
                              true
                          ? const Icon(
                              Icons.favorite_outlined,
                              color: Colors.red,
                            )
                          : const Icon(Icons.favorite_outlined),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
