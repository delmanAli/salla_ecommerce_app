import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sala_shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:sala_shop_app/layout/shop_app/cubit/states.dart';
import 'package:sala_shop_app/models/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  static const String routeName = 'categoriesScreen';
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      builder: (context, state) {
        return GridView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10),
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 11,
            mainAxisSpacing: 11,
          ),
          itemCount: ShopCubit.get(context).categoriesModel.data.data.length,
          itemBuilder: (context, index) => gridTiles(
              ShopCubit.get(context).categoriesModel.data.data[index]),
        );
        // return ListView.separated(
        //   itemBuilder: (context, index) => buildCategoryItems(
        //     ShopCubit.get(context).categoriesModel.data.data[index],
        //   ),
        //   separatorBuilder: (context, index) => myDivider(),
        //   itemCount: ShopCubit.get(context).categoriesModel.data.data.length,
        // );
      },
      listener: (context, state) {},
    );
  }

  Widget gridTiles(DataModel dataModel) {
    return GridTile(
      child: Image(
        image: NetworkImage(dataModel.image),
        fit: BoxFit.cover,
        // width: 80,
        // height: 80,
      ),
      footer: GridTileBar(
        title: Text(
          dataModel.name,
          textAlign: TextAlign.center,
          style: TextStyle(
            // fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black54,
        trailing: Icon(
          Icons.arrow_forward_ios,
        ),
      ),
    );
  }

  // Widget buildCategoryItems(DataModel dataModel) {
  //   return Padding(
  //     padding: const EdgeInsets.all(20),
  //     child: Row(
  //       children: [
  //         Image(
  //           image: NetworkImage(dataModel.image),
  //           fit: BoxFit.cover,
  //           width: 80,
  //           height: 80,
  //         ),
  //         SizedBox(
  //           width: 20,
  //         ),
  //         Text(
  //           dataModel.name,
  //           style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         Spacer(),
  //         Icon(
  //           Icons.arrow_forward_ios,
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
