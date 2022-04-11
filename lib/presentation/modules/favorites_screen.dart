import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/model/favourite_model.dart';
import 'package:shop_app/logic/shop_cubit/shop_cubit.dart';

import '../../logic/shop_cubit/shop_state.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var favouriteModel = ShopCubit.get(context).favouriteModel;
        return favouriteModel != null ?
        ListView.builder(
          itemBuilder: (context,index)=> buildFavouriteScreen(favouriteModel.data!.data[index],context),
          itemCount: favouriteModel.data!.data.length,
        )
         : const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildFavouriteScreen(DataFavourite dataFavourite, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Column(
          children: [
            dataFavourite.product!.discount != 0
                ? const SizedBox(
              height: 70,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Align(
                  alignment: AlignmentDirectional.topEnd,
                  child: CircleAvatar(
                    radius: 40,
                    child: Text(
                      'Offer',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ),
            )
                : Container(),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FadeInImage.assetNetwork(
                    image: dataFavourite.product!.image.toString(),
                    height: 150,
                    width: 150,
                    placeholder: 'assets/images/loading.gif',
                  ),
                  const SizedBox(width: 6,),
                  Expanded(
                    child: Text(
                      dataFavourite.product!.name.toString(),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16,),
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
                    "\$ ${dataFavourite.product!.price!.round()}",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.blue),
                  ),
                  if (dataFavourite.product!.discount != 0)
                    Text(
                      "  \$ ${dataFavourite.product!.oldPrice!
                          .round()}",
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black38,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeFavourite(
                          productId: dataFavourite.product!.id);
                    },
                    iconSize: 30,
                    icon: ShopCubit.get(context)
                        .listFavourite![dataFavourite.product!.id] == true ? const Icon(
                      Icons.favorite_outlined,
                      color: Colors.red,
                    ) : const Icon(Icons.favorite_outlined),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
