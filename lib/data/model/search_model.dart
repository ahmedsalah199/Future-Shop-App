class SearchModel {
  bool? status;
  Data? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ?  Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<DataSearch> data = [];
  bool? inFavorites ;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    inFavorites = json['in_favorites'];
    if (json['data'] != null) {
      json['data'].forEach((element) {
        data.add(DataSearch.fromJson(element));
      });
    }
  }
}


class DataSearch {
  int? id;
  dynamic price;
  String? image;
  String? name;
  String? description;


  DataSearch.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }

}
