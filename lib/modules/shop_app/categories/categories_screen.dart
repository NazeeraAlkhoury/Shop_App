import 'package:buildcondition/buildcondition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/layout/shopApp/cubit/cubit.dart';
import 'package:flutter_application_2/layout/shopApp/cubit/states.dart';
import 'package:flutter_application_2/models/shop_app/categories_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        var categories = cubit.categoriesModel;
        return Scaffold(
          body: BuildCondition(
            condition: cubit.categoriesModel != null,
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) =>
                  buildCatItem(categories!.data!.data[index]),
              separatorBuilder: (context, index) => Divider(),
              itemCount: categories!.data!.data.length,
            ),
            fallback: (context) => Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildCatItem(DataModel dataModel) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${dataModel.image}'),
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Text(
                '${dataModel.name}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios),
          ],
        ),
      );
}
