import 'package:flutter/material.dart';

import 'package:flutter_application_2/modules/shop_app/search/cubit/cubit.dart';
import 'package:flutter_application_2/modules/shop_app/search/cubit/states.dart';

import 'package:flutter_application_2/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormFaild(
                      controller: searchController,
                      label: 'Search',
                      prefix: Icons.search,
                      type: TextInputType.text,
                      validated: (String? value) {
                        if (value!.isEmpty) {
                          return 'Enter text to search';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        print(value);
                      },
                      onTap: () {
                        print('enter text');
                      },
                      onSubmitted: (value) {
                        if (formKey.currentState!.validate()) {
                          SearchCubit.get(context).searchProduct(value);
                        }
                      },
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) => buildListItem(
                            cubit.searchModel!.data!.data[index],
                            context,
                            isOldPrice: false,
                          ),
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: cubit.searchModel!.data!.data.length,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
