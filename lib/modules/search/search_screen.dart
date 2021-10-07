import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sala_shop_app/modules/search/cubit/cubit.dart';
import 'package:sala_shop_app/modules/search/cubit/states.dart';
import 'package:sala_shop_app/shared/components/default_buttom.dart';
import 'package:sala_shop_app/shared/components/default_form_field.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = 'searchScreen';
  final GlobalKey<FormState> fromKeys = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  defaultFormField(
                    controller: searchController,
                    type: TextInputType.text,
                    validate: 'Enter Text To Search',
                    label: 'search',
                    prefix: Icons.search,
                    onSubmit: (String text) {
                      SearchCubit.get(context).search(text);
                    },
                  ),
                  SizedBox(height: 11),
                  if (state is SearchLoadingState) LinearProgressIndicator(),
                  if (state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) => buildFavoritesItems(
                          SearchCubit.get(context).searchModel.data.data[index],
                          context,
                        ),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: SearchCubit.get(context)
                            .searchModel
                            .data
                            .data
                            .length,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
        listener: (context, state) {},
      ),
    );
  }

  Widget buildFavoritesItems(model, context) {
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
