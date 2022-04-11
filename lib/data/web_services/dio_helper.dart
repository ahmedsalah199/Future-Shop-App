import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static initDio() {
    dio = Dio(BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
    ));
  }

  static Future<dynamic> postData({ required String path, required Map <String, dynamic> data, Map <String, dynamic>? query }) async {
    try {
      Response response = await dio!.post(
        path,
        data: data,
        queryParameters: query,
      );
      return response.data;
    } on DioError catch (error) {
      throw Exception(error.toString());
    }
  }


  static Future<dynamic> putData({ required String path, required Map <String, dynamic> data, Map <String, dynamic>? query }) async {
    try {
      Response response = await dio!.put(
        path,
        data: data,
        queryParameters: query,
      );
      return response.data;
    } on DioError catch (error) {
      throw Exception(error.toString());
    }
  }

  static Future<dynamic> getData({required String path,  Map<String, dynamic>? query})  async{
    try{
      Response response = await dio!.get(path, queryParameters: query);
      return response.data ;
    }  on DioError catch (error) {
      throw Exception(error.toString());
    }
  }
}
