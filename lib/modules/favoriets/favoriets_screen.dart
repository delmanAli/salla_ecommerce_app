import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sala_shop_app/layout/shop_app/cubit/states.dart';
import 'package:sala_shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:sala_shop_app/models/favorites_model.dart';
import 'package:sala_shop_app/shared/components/default_buttom.dart';
import 'package:sala_shop_app/shared/styles/colors.dart';

class FavorietsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoriteState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildFavoritesItems(
              ShopCubit.get(context).favoritesModel.data.data[index],
              context,
            ),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).favoritesModel.data.data.length,
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget buildFavoritesItems(FavoritData model, context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.product.image),
                  width: 120,
                  height: 120,

                  fit: BoxFit.cover,
                  // fit: BoxFit.fill,
                ),
                if (model.product.discount != 0)
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
            SizedBox(width: 21),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    // textAlign: TextAlign.center,
                    style: TextStyle(height: 1.3),
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Text(
                        '${model.product.price.round()}',
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
                      if (model.product.discount != 0)
                        Text(
                          '${model.product.oldPrice.round()}',
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
                            backgroundColor: ShopCubit.get(context)
                                    .favorties[model.product.id]
                                ? defultColors
                                : Colors.grey,
                            child: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                            )),
                        iconSize: 13.0,
                        onPressed: () {
                          ShopCubit.get(context)
                              .changeFavorites(model.product.id);
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
