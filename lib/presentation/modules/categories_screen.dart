import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/logic/shop_cubit/shop_cubit.dart';

import '../../logic/shop_cubit/shop_state.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopState>(
      listener: (context, state) {},
      builder: (context, state) {
        var categoriesModel = ShopCubit
            .get(context)
            .categoriesModel;
        return categoriesModel != null ?
        ListView.separated(
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 160,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.blue[300],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:  FadeInImage.assetNetwork(
                        image: categoriesModel.data!.data[index].image.toString(),
                        height: 150,
                        width: 150,
                        fit: BoxFit.cover,
                        placeholder: 'assets/images/loading.gif',
                      )
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( categoriesModel.data!.data[index].name.toString()
                            , style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),),
                          const ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text('See all'
                              , style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),),
                            trailing: Icon(Icons.arrow_forward_outlined,color: Colors.white,),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ) ,
          separatorBuilder: (context, index) => const SizedBox(height: 5,),
          itemCount: categoriesModel.data!.data.length,
        ) : const Center(child: CircularProgressIndicator());

      },
    );
  }
}
