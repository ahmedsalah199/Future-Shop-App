import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/data/model/home_model.dart';
import 'package:shop_app/logic/shop_cubit/shop_cubit.dart';

import '../../logic/shop_cubit/shop_state.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var homeModel = ShopCubit.get(context).homeModel;
        var categoriesModel = ShopCubit.get(context).categoriesModel;
        var cubit = ShopCubit.get(context);
        return homeModel != null && categoriesModel != null
            ? SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    buildCarouselBanners(homeModel),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Categories',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          SizedBox(
                            height: 135,
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: cubit.categoriesModel!.data!.data.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                width: 15,
                              ),
                              itemBuilder: (context, index) {
                                return Column(
                                  children: [
                                    Container(
                                      child: FadeInImage.assetNetwork(
                                        image: cubit.categoriesModel!.data!.data[index].image.toString(),
                                        height: 95,
                                        width: 95,
                                        fit: BoxFit.cover,
                                        placeholder: 'assets/images/loading.gif',
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(60),
                                        color: Colors.grey[100],
                                      ),
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                    ),
                                    const SizedBox(height: 7,),
                                    Expanded(
                                      child: Container(
                                        child: Text(
                                          cubit.categoriesModel!.data!.data[index].name.toString(),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white
                                          ),
                                        ),
                                        color: Colors.black38,
                                        padding: const EdgeInsets.all(7),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 5,),
                          const Text(
                            'Top Products',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            color: Colors.grey[100],
                            child: GridView.count(
                              crossAxisCount: 2,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 10,
                              childAspectRatio: 1 / 2.34,
                              children: List.generate(
                                homeModel.data!.products!.length,
                                (index) => buildProduct(homeModel.data!.products![index], index,
                                    cubit.favourite, cubit.iconFavourite ,context),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ]))
            : const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget buildProduct(
      ProductsModel productModel, int index, VoidCallback function, Icon icon , context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Column(
        children: [
          productModel.discount != 0
              ? const SizedBox(
                  height: 50,
                  child: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Align(
                      alignment: AlignmentDirectional.topEnd,
                      child: CircleAvatar(
                        radius: 30,
                        child: Text(
                          'Offer',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                )
              : Container(
                  height: 50,
                ),
          FadeInImage.assetNetwork(
            image: productModel.image.toString(),
            height: 200,
            width: double.infinity,
            placeholder: 'assets/images/loading.gif',
          ),
          Container(
            height: 90,
            padding: const EdgeInsetsDirectional.only(bottom: 5),
            child: Text(
              productModel.name.toString(),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 16, height: 1.2),
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
                  "\$ ${productModel.price!.round()}",
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.blue),
                ),
                if (productModel.discount != 0)
                  Text(
                    "  \$ ${productModel.oldPrice!.round()}",
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
                  onPressed: (){
                    ShopCubit.get(context).changeFavourite(productId: productModel.id);
                  },
                  iconSize: 30,
                  icon: ShopCubit.get(context).listFavourite![productModel.id] == true ?  const Icon(
                    Icons.favorite_outlined,
                    color: Colors.red,
                  ) : icon,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding buildCarouselBanners(HomeModel homeModel) {
    return  Padding(
      padding: const EdgeInsetsDirectional.only(top: 20),
      child: CarouselSlider(
        items: homeModel.data!.banners!
            .map((banner) => ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: FadeInImage.assetNetwork(
                  image: banner.image.toString(),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: 'assets/images/loading.gif',
                )
              ))
            .toList(),
        options: CarouselOptions(
          autoPlay: true,
          height: 200,
          viewportFraction: .9,
          enlargeCenterPage: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          initialPage: 0,
        ),
      ),
    );
  }
}
