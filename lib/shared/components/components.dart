import 'package:bot_toast/bot_toast.dart';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/layout/shopApp/cubit/cubit.dart';

import 'package:flutter_application_2/shared/styles/colors.dart';

Widget defaultButton({
  double width: double.infinity,
  Color backgrond: Colors.blue,
  required Function function,
  required String text,
  double radius = 0.0,
  bool isUpperCase = true,
}) =>
    Container(
      width: width,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(radius),
        color: backgrond,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          '${isUpperCase ? text.toUpperCase() : text}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );

Widget defaultFormFaild({
  required TextEditingController controller,
  required String label,
  required IconData prefix,
  required TextInputType type,
  Function? onSubmitted,
  Function? onChanged,
  required Function validated,
  bool isObscure: false,
  IconData? suffix,
  Function? onSuffix,
  Function? onTap,
  //bool isSuffix = false,
}) =>
    TextFormField(
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            prefix,
          ),
          border: OutlineInputBorder(),
          suffixIcon: suffix != null
              ? IconButton(
                  onPressed: () {
                    onSuffix!();
                  },
                  icon: Icon(
                    suffix,
                  ),
                )
              : null),
      keyboardType: type,
      onFieldSubmitted: (s) {
        onSubmitted!(s);
      },
      // onChanged: (String? s) {
      //   onChanged!(s!);
      // },
      onChanged: (s) {
        onChanged!(s);
      },
      validator: (String? value) {
        return validated(value!);
      },
      obscureText: isObscure,

      onTap: () {
        onTap!();
      },
      // validator: (String? value) {
      //   if (value!.isEmpty) {
      //     return 'Email Adress must not be empty ';
      //   }
      //   return null;
      // },
    );

Widget defaultTextButton({required Function function, required String text}) =>
    TextButton(
      onPressed: () {
        function();
      },
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20.0),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey,
      ),
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => widget), (route) => false);

void showToast({
  required String msg,
  required ToastStates state,
}) =>
    BotToast.showText(
      text: msg,
      duration: Duration(
        seconds: 5,
      ),
      contentColor: toastColor(state),
      clickClose: true,
      align: Alignment.bottomCenter,
    );

enum ToastStates { SUCCESS, ERROR, WARNING }

Color toastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.grey;
      break;
  }
  return color;
}

Widget buildListItem(model, context, {bool isOldPrice = true}) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120.0,
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    '${model.image}',
                  ),
                  width: 120.0,
                  height: 120.0,
                ),
                if (model.discount != 0 && isOldPrice)
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
            SizedBox(
              width: 20.0,
            ),
            Expanded(
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
                  Spacer(),
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
                      if (model.discount != 0 && isOldPrice)
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
      ),
    );
