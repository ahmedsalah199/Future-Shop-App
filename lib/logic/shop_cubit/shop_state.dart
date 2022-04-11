
import 'package:shop_app/data/model/profile_model.dart';
import 'package:shop_app/data/model/update_profile_model.dart';

abstract class ShopState {}

class ShopInitial extends ShopState {}
class ChangeBottomNavigationState extends ShopState {}
class IconFavouriteState extends ShopState {}
class UpdateButtonState extends ShopState {}



class ShopLoadingHomeDataState extends ShopState {}
class ShopSuccessHomeDataState extends ShopState {}
class ShopErrorHomeDataState extends ShopState {}


class ShopLoadingCategoriesState extends ShopState {}
class ShopSuccessCategoriesState extends ShopState {}
class ShopErrorCategoriesState extends ShopState {}

class ShopLoadingProfileState extends ShopState {}
class ShopSuccessProfileState extends ShopState {
  final ProfileModel profileModel ;
  ShopSuccessProfileState(this.profileModel);
}
class ShopErrorProfileState extends ShopState {}


class ShopChangeFavouriteState extends ShopState {}
class ShopSuccessChangeFavouriteState extends ShopState {}
class ShopErrorChangeFavouriteState extends ShopState {}


class ShopLoadingGetFavouriteState extends ShopState {}
class ShopSuccessGetFavouriteState extends ShopState {}
class ShopErrorGetFavouriteState extends ShopState {}

class ShopLoadingUpdateProfileState extends ShopState {}
class ShopSuccessUpdateProfileState extends ShopState {
  final UpdateProfileModel updateProfileModel ;
  ShopSuccessUpdateProfileState(this.updateProfileModel);
}
class ShopErrorUpdateProfileState extends ShopState {}
class ChangeIconVisibility extends ShopState {}




