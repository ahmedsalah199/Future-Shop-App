import 'package:dio/dio.dart';
import 'package:shop_app/data/model/categories_model.dart';
import 'package:shop_app/data/model/favourite_model.dart';
import 'package:shop_app/data/model/home_model.dart';
import 'package:shop_app/data/model/profile_model.dart';
import 'package:shop_app/data/model/register_model.dart';
import 'package:shop_app/data/model/search_model.dart';
import 'package:shop_app/data/model/update_profile_model.dart';
import 'package:shop_app/data/web_services/dio_helper.dart';

import '../model/change_favourite_model.dart';
import '../model/login_model.dart';

class Repository {

  static Future postLoginData({ required String path, required Map <String ,dynamic> allData , Map <String ,dynamic>? query , String lang = "ar"}) async {
      try {
        DioHelper.dio!.options.headers = {
          "lang": lang,
          "Content-Type": "application/json"
        };
        var data = await DioHelper.postData(path: path, data: allData, query: query,);

        return LoginModel.fromJson(data);
      } on DioError catch (error) {
        throw Exception(error.toString());
      }
    }

  static Future<HomeModel> getAllHomeData({required String path,  Map<String, dynamic>? query , String? token , String lang = "ar"})  async{
    try{
      DioHelper.dio!.options.headers = {
        "Authorization" : token,
        "lang": lang,
        "Content-Type": "application/json"
      };
      var data = await DioHelper.getData(path: path,query: query);
      return HomeModel.fromJson(data) ;
    }  on DioError catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<CategoriesModel> getCategories({required String path,  Map<String, dynamic>? query , String? token , String lang = "ar"})  async{
    try{
      DioHelper.dio!.options.headers = {
        "lang": lang,
        "Content-Type": "application/json" ,
      };
      var data = await DioHelper.getData(path: path,query: query);
      return CategoriesModel.fromJson(data) ;
    }  on DioError catch (error) {
      throw Exception(error.toString());
    }
  }


  static Future postFavoriteItem({ required String path, required Map <String ,dynamic> allData , required String? token , String lang = "ar"}) async {
    try {
      DioHelper.dio!.options.headers = {
        "lang": lang,
        "Content-Type": "application/json" ,
        "Authorization" : token
      };
      var data = await DioHelper.postData(path: path, data: allData,);

      return ChangeFavouriteModel.fromJson(data);
    } on DioError catch (error) {
      throw Exception(error.toString());
    }
  }


  static Future<FavouriteModel> getFavouriteData({required String path,  Map<String, dynamic>? query , String? token , String lang = "ar"})  async{
    try{
      DioHelper.dio!.options.headers = {
        "lang": lang,
        "Content-Type": "application/json",
        "Authorization" : token
      };
      var data = await DioHelper.getData(path: path,query: query);
      return FavouriteModel.fromJson(data) ;
    }  on DioError catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<ProfileModel> getProfileData({required String path,  Map<String, dynamic>? query , String? token  , String lang = "ar"})  async{
    try{
      DioHelper.dio!.options.headers = {
        "lang": lang,
        "Content-Type": "application/json",
        "Authorization" : token
      };
      var data = await DioHelper.getData(path: path,query: query);
      return ProfileModel.fromJson(data) ;
    }  on DioError catch (error) {
      throw Exception(error.toString());
    }
  }


  static Future postRegister({ required String path, required Map <String ,dynamic> allData , String lang = "ar"}) async {
    try {
      DioHelper.dio!.options.headers = {
        "lang": lang,
        "Content-Type": "application/json" ,
      };
      var data = await DioHelper.postData(path: path, data: allData,);
      return SignUpModel.fromJson(data);
    } on DioError catch (error) {
      throw Exception('repos  ${error.toString()}');
    }
  }

  static Future putDataProfile({ required String path, required Map <String ,dynamic> allData , required String? token , String lang = "ar"}) async {
    try {
      DioHelper.dio!.options.headers = {
        "lang": lang,
        "Content-Type": "application/json" ,
        "Authorization": token ,
      };
      var data = await DioHelper.putData(path: path, data: allData,);
      return UpdateProfileModel.fromJson(data);
    } on DioError catch (error) {
      throw Exception('repos  ${error.toString()}');
    }
  }

  static Future postSearch({ required String path, required Map <String ,dynamic> allData , required String? token , String lang = "ar"}) async {
    try {
      DioHelper.dio!.options.headers = {
        "lang": lang,
        "Content-Type": "application/json" ,
        "Authorization" : token
      };
      var data = await DioHelper.postData(path: path, data: allData,);

      return SearchModel.fromJson(data);
    } on DioError catch (error) {
      throw Exception(error.toString());
    }
  }

}

