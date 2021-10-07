import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sala_shop_app/layout/shop_app/cubit/states.dart';
import 'package:sala_shop_app/models/categories_model.dart';
import 'package:sala_shop_app/models/change_favorites_model.dart';
import 'package:sala_shop_app/models/favorites_model.dart';
import 'package:sala_shop_app/models/home_model.dart';
import 'package:sala_shop_app/models/user_modal.dart';
import 'package:sala_shop_app/modules/categories/categories_screen.dart';
import 'package:sala_shop_app/modules/favoriets/favoriets_screen.dart';
import 'package:sala_shop_app/modules/products/products_screen.dart';
import 'package:sala_shop_app/modules/settings/settings_screen.dart';
import 'package:sala_shop_app/shared/components/constant.dart';
import 'package:sala_shop_app/shared/network/remote/dio_helper.dart';
import 'package:sala_shop_app/shared/network/remote/end_points.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomNavScreen = [
    ProductsScreen(),
    CategoriesScreen(),
    FavorietsScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavScreen(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  Map<int, bool> favorties = {};

  HomeModel homeModel;
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME,
      token: token,
    ).then((res) {
      homeModel = HomeModel.fromJson(res.data);
      print(homeModel.status);
      homeModel.data.products.forEach((element) {
        favorties.addAll({
          element.id: element.inFavorites,
        });
      });
      // print(favorties.toString());
      emit(ShopSuccessHomeDataState());
    }).catchError((err) {
      print(err.toString());
      emit(ShopErrorHomeDataState());
    });
  }

//......
  CategoriesModel categoriesModel;
  void getCategories() {
    // emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: CATEGORIES,
      token: token,
    ).then((res) {
      categoriesModel = CategoriesModel.fromJson(res.data);
      // print(homeModel.data.banners[0].image);
      // print(homeModel.status);
      emit(ShopSuccessCategoriesState());
    }).catchError((err) {
      // print(err.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel changeFavoritesModel;
  void changeFavorites(int productId) {
    favorties[productId] = !favorties[productId];
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((res) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(res.data);
      // print(res.data);
      if (!changeFavoritesModel.status) {
        favorties[productId] = !favorties[productId];
      } else {
        getFavorites();
      }
      emit(ShopSuccessFavoritesState(changeFavoritesModel));
    }).catchError((err) {
      // if (!changeFavoritesModel.status) {
      favorties[productId] = !favorties[productId];
      // }
      emit(ShopErrorFavoritesState());
    });
  }

  FavoritesModel favoritesModel;
  void getFavorites() {
    emit(ShopLoadingGetFavoriteState());
    // print('loadind favoritss...');
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((res) {
      favoritesModel = FavoritesModel.fromJson(res.data);
      // print('fav Model...: ${favoritesModel.data.data}');
      emit(ShopSuccessGetFavoriteState());
    }).catchError((err) {
      print(err.toString());
      emit(ShopErrorGetFavoriteState());
    });
  }

  LoginModal userModal;
  void getUserProfile() {
    emit(ShopLoadingUserProfileState());
    // print('loadind favoritss...');
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((res) {
      userModal = LoginModal.fromJson(res.data);
      // print(userModal.data.name);
      emit(ShopSuccessUserProfileState(userModal));
    }).catchError((err) {
      print(err.toString());
      emit(ShopErrorUserProfileState());
    });
  }

  // LoginModal userModal;
  void updateUserProfile({
    String name,
    String email,
    String phone,
  }) {
    emit(ShopLoadingUpdateUserProfileState());
    // print('loadind favoritss...');
    DioHelper.putData(
      url: UPDATE_PEOFILE,
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
      token: token,
    ).then((res) {
      userModal = LoginModal.fromJson(res.data);
      // print(userModal.data.name);
      emit(ShopSuccessUpdateUserProfileState(userModal));
    }).catchError((err) {
      print(err.toString());
      emit(ShopErrorUpdateUserProfileState());
    });
  }
}
