class ProfileModel {
  bool? status ;
  DataProfileModel? data ;
  ProfileModel.fromJson (Map<String,dynamic> json) {
    status = json ['status'] ;
    data = json ['data'] != null ? DataProfileModel.formJson(json ['data']) : null ;
  }

}

class DataProfileModel {
  int? id ;
  String? name ;
  String? email ;
  String? phone ;
  String? image ;
  String? token ;
 DataProfileModel.formJson (Map<String,dynamic> json){
   id = json['id'];
   name = json['name'];
   email = json['email'];
   phone = json['phone'];
   image = json['image'];
   token = json['token'];
 }

}