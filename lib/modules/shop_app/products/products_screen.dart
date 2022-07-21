import 'package:buildcondition/buildcondition.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_2/layout/shopApp/cubit/cubit.dart';
import 'package:flutter_application_2/layout/shopApp/cubit/states.dart';
import 'package:flutter_application_2/models/shop_app/categories_model.dart';
import 'package:flutter_application_2/models/shop_app/home_model.dart';
import 'package:flutter_application_2/shared/components/components.dart';
import 'package:flutter_application_2/shared/styles/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoritesState) {
          if (state.changeFavoritesModel!.status!) {
            showToast(
                msg: state.changeFavoritesModel!.message!,
                state: ToastStates.SUCCESS);
          }
          if (!state.changeFavoritesModel!.status!) {
            showToast(
                msg: state.changeFavoritesModel!.message!,
                state: ToastStates.ERROR);
          }
        }
      },
      builder: (context, state) {
        var model = ShopCubit.get(context).homeModel;
        var categories = ShopCubit.get(context).categoriesModel;
        return Scaffold(
          body: BuildCondition(
            // ignore: unnecessary_null_comparison
            condition: model != null && categories != null,
            builder: (context) => productBuilder(model!, categories!, context),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }

  Widget productBuilder(HomeModel model, CategoriesModel categories, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model.data!.banners
                  .map(
                    (e) => Image(
                      image: NetworkImage(
                        '${e.image}',
                      ),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Image(
                          image: AssetImage('assets/images/on.png'),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                reverse: false,
                scrollDirection: Axis.horizontal,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                viewportFraction: 1.0,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                    height: 100.0,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categories.data!.data[index]),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 5,
                      ),
                      itemCount: categories.data!.data.length,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Text(
                    'New Products',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Container(
              color: Colors.grey[300],
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                children: List.generate(
                  model.data!.products.length,
                  (index) =>
                      buildGridProduct(model.data!.products[index], context),
                ),
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: 1 / 1.58,
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(ProductModel model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    '${model.image}',
                  ),
                  width: double.infinity,
                  height: 200.0,
                ),
                if (model.discount != 0)
                  Container(
                    padding: EdgeInsets.all(3.0),
                    color: Colors.red,
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.name}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.0,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text(
                        '${model.price}',
                        style: TextStyle(
                          fontSize: 14.0,
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      if (model.discount != 0)
                        Text(
                          '${model.oldPrice}',
                          style: TextStyle(
                            fontSize: 14.0,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context)
                              .changeFavorites(productId: model.id!);
                        },
                        icon: CircleAvatar(
                          backgroundColor:
                              ShopCubit.get(context).favorites[model.id]!
                                  ? defaultColor
                                  : Colors.grey,
                          child: Icon(
                            Icons.favorite_border,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel dataModel) => Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage(
              '${dataModel.image}',
            ),
            width: 100.0,
            height: 100.0,
            fit: BoxFit.cover,
          ),
          Container(
            width: 100.0,
            color: Colors.black.withOpacity(0.3),
            child: Text(
              '${dataModel.name}',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
              maxLines: 1,
            ),
          ),
        ],
      );
}
