import 'package:sala_shop_app/models/change_favorites_model.dart';
import 'package:sala_shop_app/models/user_modal.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopSuccessCategoriesState extends ShopStates {}

class ShopErrorCategoriesState extends ShopStates {}

class ShopChangeFavoritesState extends ShopStates {}

class ShopSuccessFavoritesState extends ShopStates {
  final ChangeFavoritesModel changeFavoritesModel;

  ShopSuccessFavoritesState(
    this.changeFavoritesModel,
  );
}

class ShopErrorFavoritesState extends ShopStates {}

class ShopLoadingGetFavoriteState extends ShopStates {}

class ShopSuccessGetFavoriteState extends ShopStates {}

class ShopErrorGetFavoriteState extends ShopStates {}

class ShopLoadingUserProfileState extends ShopStates {}

class ShopSuccessUserProfileState extends ShopStates {
  final LoginModal loginModal;

  ShopSuccessUserProfileState(this.loginModal);
}

class ShopErrorUserProfileState extends ShopStates {}

class ShopLoadingUpdateUserProfileState extends ShopStates {}

class ShopSuccessUpdateUserProfileState extends ShopStates {
  final LoginModal loginModal;

  ShopSuccessUpdateUserProfileState(this.loginModal);
}

class ShopErrorUpdateUserProfileState extends ShopStates {}
