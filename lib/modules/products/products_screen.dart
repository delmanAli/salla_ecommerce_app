import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:sala_shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:sala_shop_app/layout/shop_app/cubit/states.dart';
import 'package:sala_shop_app/models/categories_model.dart';
import 'package:sala_shop_app/models/home_model.dart';
import 'package:sala_shop_app/shared/components/toast_erorr.dart';
import 'package:sala_shop_app/shared/styles/colors.dart';

class ProductsScreen extends StatelessWidget {
  static const String routeName = 'productScreen';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null,
            builder: (context) => prodctBuilder(
                  ShopCubit.get(context).homeModel,
                  ShopCubit.get(context).categoriesModel,
                  context,
                ),
            fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ));
      },
      listener: (context, state) {
        if (state is ShopSuccessFavoritesState) {
          if (!state.changeFavoritesModel.status) {
            showToast(
              text: state.changeFavoritesModel.message,
              state: ToastStates.ERROR,
            );
          }
        }
      },
    );
  }

  Widget prodctBuilder(
    HomeModel model,
    CategoriesModel categoriesModel,
    context,
  ) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items: model.data.banners
                .map((banner) => Image(
                      image: NetworkImage(banner.image),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ))
                .toList(),
            options: CarouselOptions(
              autoPlay: true,
              height: 200,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              viewportFraction: 1,
              scrollDirection: Axis.horizontal,
            ),
          ),
          SizedBox(height: 9),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(height: 9),
              
                //..........
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) => buildCategoriesItem(
                      categoriesModel.data.data[index],
                    ),
                    // buildCategoriesTile(categoriesModel.data.data[index]),
                    separatorBuilder: (context, index) => SizedBox(width: 10),
                    itemCount: categoriesModel.data.data.length,
                  ),
                ),
                // GridView.builder(
                //   padding: EdgeInsets.symmetric(horizontal: 6),
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     childAspectRatio: 3 / 2,
                //     crossAxisSpacing: 1,
                //     mainAxisSpacing: 1,
                //   ),
                //   itemCount: categoriesModel.data.data.length,
                //   itemBuilder: (context, index) => buildCategoriesTile(
                //     categoriesModel.data.data[index],
                //   ),
                // ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  'New Products',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 2,
          // ),

          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 1,
            crossAxisSpacing: 1,
            childAspectRatio: 1 / 1.58,
            children: List.generate(
              model.data.products.length,
              (index) => buidGridProduct(
                model.data.products[index],
                context,
              ),
            ),
          ),
          //
          // Expanded(
          //   child: GridView.builder(
          //     padding: EdgeInsets.symmetric(horizontal: 6),
          //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       childAspectRatio: 3 / 4,
          //       crossAxisSpacing: 3,
          //       mainAxisSpacing: 3,
          //     ),
          //     itemCount: model.data.products.length,
          //     itemBuilder: (context, index) =>
          //         gridTiles(model.data.products[index]),
          //   ),
          // ),
        ],
      ),
    );
  }

  // Widget gridTiles(ProductModel model) {
  //   return GridTile(
  //     child: Image(
  //       image: NetworkImage(model.image),
  //       // width: double.infinity,
  //       // height: 200,
  //       // fit: BoxFit.fill,
  //     ),
  //     header: GridTileBar(
  //       leading: model.discount != 0
  //           ? null
  //           : Container(
  //               color: Colors.red,
  //               child: Text(
  //                 'DISCOUNT',
  //                 style: TextStyle(
  //                   fontSize: 8,
  //                   color: Colors.white,
  //                 ),
  //               ),
  //             ),
  //     ),
  //     footer: GridTileBar(
  //       backgroundColor: Colors.black54,
  //       trailing: IconButton(
  //         icon: Icon(
  //           Icons.favorite_border,
  //         ),
  //         onPressed: () {},
  //       ),
  //       title: Text(
  //         model.name,
  //         maxLines: 2,
  //         textAlign: TextAlign.center,
  //       ),
  //       subtitle: Row(
  //         children: [
  //           Text(
  //             '${model.price.round()}',
  //             // textAlign: TextAlign.center,
  //             style: TextStyle(
  //               fontSize: 13,
  //               color: Colors.amber,
  //               // height: 1.4,
  //             ),
  //           ),
  //           SizedBox(
  //             width: 7,
  //           ),
  //           if (model.discount != 0)
  //             Text(
  //               '${model.oldPrice.round()}',
  //               style: TextStyle(
  //                 fontSize: 12,
  //                 color: Colors.grey,
  //                 decoration: TextDecoration.lineThrough,
  //               ),
  //             ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget buidGridProduct(
    ProductModel model,
    context,
  ) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 200,
                // fit: BoxFit.fill,
              ),
              if (model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'DISCOUNT',
                    style: TextStyle(
                      fontSize: 8,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  // textAlign: TextAlign.center,
                  style: TextStyle(height: 1.3),
                ),
                Row(
                  children: [
                    Text(
                      '${model.price.round()}',
                      // textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.amber,
                        // height: 1.4,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice.round()}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    Spacer(),
                    IconButton(
                      icon: CircleAvatar(
                        radius: 15,
                        backgroundColor:
                            ShopCubit.get(context).favorties[model.id]
                                ? defultColors
                                : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        ),
                      ),
                      iconSize: 13.0,
                      onPressed: () {
                        ShopCubit.get(context).changeFavorites(model.id);
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCategoriesItem(DataModel dataModel) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage(dataModel.image),
          // fit: BoxFit.cover,
          height: 100,
          width: 100,
        ),
        Container(
          color: Colors.black54,
          width: 100,
          child: Text(
            dataModel.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  // Widget buildCategoriesTile(DataModel dataModel) {
  //   return GridTile(
  //     child: Image(
  //       image: NetworkImage(dataModel.image),
  //       // fit: BoxFit.cover,
  //       // height: 100,
  //       // width: 100,
  //     ),
  //     footer: GridTileBar(
  //       title: Text(dataModel.name),
  //     ),
  //   );
  // }
}

// https://student.valuxapps.com/storage/uploads/categories/161950183360VJK.best-offer-sale-banner-vector.jpg
