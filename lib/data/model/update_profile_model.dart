class UpdateProfileModel {
  bool? status ;
  String? message ;
  UpdateData? data ;
  UpdateProfileModel.fromJson(Map<String,dynamic> json) {
    status = json ["status"];
    message = json ["message"];
    data = json ["data"] == null ? null : UpdateData.fromJson(json ["data"]);
  }
}
class UpdateData {
  int? id ;
  String? name ;
  String? email ;
  String? phone ;
  String? password ;
  String? image ;
  String? token ;
  UpdateData.fromJson (Map<String,dynamic> json) {
    id = json['id'] ;
    name = json['name'] ;
    email = json['email'] ;
    phone = json['phone'] ;
    password = json['password'] ;
    image = json['image'] ;
    token = json['token'] ;
  }

}


