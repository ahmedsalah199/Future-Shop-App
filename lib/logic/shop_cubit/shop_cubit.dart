import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/presentation/modules/categories_screen.dart';
import 'package:shop_app/data/model/categories_model.dart';
import 'package:shop_app/data/model/change_favourite_model.dart';
import 'package:shop_app/data/model/favourite_model.dart';
import 'package:shop_app/data/model/home_model.dart';
import 'package:shop_app/data/model/profile_model.dart';
import 'package:shop_app/data/model/update_profile_model.dart';
import 'package:shop_app/data/repository/repository.dart';
import 'package:shop_app/presentation/modules/favorites_screen.dart';
import 'package:shop_app/logic/shop_cubit/shop_state.dart';
import 'package:shop_app/presentation/modules/products_screen.dart';
import 'package:shop_app/presentation/modules/settings_screen.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/components/end_point.dart';

import '../../data/model/change_favourite_model.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  List<Widget> screens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavigationBarItem = [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.apps_outlined), label: "Category"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.favorite_outlined), label: "Favorites"),
    const BottomNavigationBarItem(
        icon: Icon(Icons.settings_outlined), label: "Settings"),
  ];

  void changeBottomNavigation(index) {
    currentIndex = index;
    emit(ChangeBottomNavigationState());
  }

  HomeModel? homeModel;
  Map<int, bool>? listFavourite = {};

  getHomeData() {
    emit(ShopLoadingHomeDataState());
    Repository.getAllHomeData(path: home, token: token, lang: "en")
        .then((value) {
      homeModel = value;
      for (var element in homeModel!.data!.products!) {
        listFavourite!.addAll({
          element.id!: element.inFavorites!,
        });
      }
      debugPrint(listFavourite.toString());
      debugPrint(value.status.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  bool isFavourite = false;

  Icon iconFavourite = const Icon(Icons.favorite_outline);

  void favourite() {
    isFavourite = !isFavourite;
    isFavourite == false
        ? iconFavourite = const Icon(Icons.favorite_outline)
        : iconFavourite = const Icon(
            Icons.favorite_outlined,
            color: Colors.red,
          );
    emit(IconFavouriteState());
  }

  CategoriesModel? categoriesModel;

  getCategories() {
    Repository.getCategories(
      path: categories,
      lang: "en",
    ).then((value) {
      categoriesModel = value;
      debugPrint(value.status.toString());
      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
      debugPrint(error.toString().toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavouriteModel? changeFavouriteModel;

  changeFavourite({required int? productId}) {
    listFavourite![productId!] = !listFavourite![productId]!;
    emit(ShopChangeFavouriteState());
    Repository.postFavoriteItem(
            path: favorites,
            lang: "en",
            allData: {"product_id": productId},
            token: token)
        .then((value) {
      changeFavouriteModel = value;
      if (changeFavouriteModel!.status == false) {
        listFavourite![productId] = !listFavourite![productId]!;
      } else {
        getFavourite();
      }
      debugPrint(changeFavouriteModel!.message.toString());
      debugPrint(listFavourite![productId].toString());
      emit(ShopSuccessChangeFavouriteState());
    }).catchError((error) {
      debugPrint(error.toString());
      listFavourite![productId] = !listFavourite![productId]!;
      emit(ShopErrorChangeFavouriteState());
    });
  }

  FavouriteModel? favouriteModel;

  getFavourite() {
    emit(ShopLoadingGetFavouriteState());
    Repository.getFavouriteData(path: favorites, lang: "en", token: token)
        .then((value) {
      favouriteModel = value;
      debugPrint(value.status.toString());
      emit(ShopSuccessGetFavouriteState());
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopErrorGetFavouriteState());
    });
  }

  ProfileModel? profileModel;

  getProfile() {
    emit(ShopLoadingProfileState());
    Repository.getProfileData(path: profile, lang: "en", token: token)
        .then((value) {
      profileModel = value;
      debugPrint('profile  ${value.data!.phone.toString()}');
      emit(ShopSuccessProfileState(profileModel!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopErrorProfileState());
    });
  }

  bool isUpDate = false;
  bool readOnly = true;
  TextInputType keyBoardName = TextInputType.name ;
  TextInputType keyBoardEmail = TextInputType.emailAddress ;
  TextInputType keyBoardPhone = TextInputType.phone ;
  TextInputType keyBoardPassword = TextInputType.visiblePassword ;

  updateIconSettings() {
    isUpDate = !isUpDate;
    readOnly = !readOnly;
    if (readOnly == true) {
       keyBoardName = TextInputType.none ;
       keyBoardEmail = TextInputType.none ;
       keyBoardPhone = TextInputType.name ;
       keyBoardPassword = TextInputType.none ;
    }
    emit(UpdateButtonState());
  }

  UpdateProfileModel? updateProfileModel;

  void updateProfile({required String name , required String email , required String password , required String phone ,}) {
    emit(ShopLoadingUpdateProfileState());
    Repository.putDataProfile(
      path: updateDataProfile,
      lang: "en",
      token: token,
      allData: {
        "name" : name ,
        "email" : email ,
        "password" : password ,
        "phone" : phone ,
      },
    ).then((value) {
      updateProfileModel = value ;
      emit(ShopSuccessUpdateProfileState(updateProfileModel!));
      debugPrint(updateProfileModel!.status.toString());
    }).catchError((error) {
      emit(ShopErrorUpdateProfileState());
      debugPrint(error.toString());
    },
    );
  }

  IconData suffixIcon = Icons.remove_red_eye ;
  bool obscureText = true ;
  void changeIconVisibility () {
    suffixIcon = obscureText ? Icons.visibility_off : Icons.remove_red_eye ;
    obscureText = !obscureText ;
    emit(ChangeIconVisibility());
  }

}
