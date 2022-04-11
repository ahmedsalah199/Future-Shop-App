class FavouriteModel {
  bool? status;
  Data? data;

  FavouriteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<DataFavourite> data = [];

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      json['data'].forEach((element) {
        data.add( DataFavourite.fromJson(element));
      });
    }
  }

}

class DataFavourite {
  int? id;
  FavouriteProduct? product;

  DataFavourite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ?  FavouriteProduct.fromJson(json['product']) : null;
  }
}

class FavouriteProduct {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  String? description;


  FavouriteProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
