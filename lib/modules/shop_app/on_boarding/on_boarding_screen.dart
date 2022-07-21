import 'package:flutter/material.dart';
import 'package:flutter_application_2/modules/shop_app/login/shop_login_screen.dart';
import 'package:flutter_application_2/shared/components/components.dart';
import 'package:flutter_application_2/shared/network/local/cache_helper.dart';

import 'package:flutter_application_2/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardModel {
  final String image;
  final String title;
  final String body;
  BoardModel({required this.image, required this.title, required this.body});
}

// ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardModel> boarding = [
    BoardModel(
        image: 'assets/images/on_boarding_1.png',
        title: 'OnBoard Title 1',
        body: 'OnBoard Body 1'),
    BoardModel(
        image: 'assets/images/on_boarding_1.png',
        title: 'OnBoard Title 2',
        body: 'OnBoard Body 2'),
    BoardModel(
        image: 'assets/images/on_boarding_1.png',
        title: 'OnBoard Title 3',
        body: 'OnBoard Body 3'),
  ];

  bool isLast = false;

  var boardController = PageController();

  void submit() {
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if (value) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
            function: () {
              submit();
            },
            text: 'skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    print('Last');
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    print('Not Last');
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    expansionFactor: 4,
                    activeDotColor: defaultColor,
                    dotColor: Colors.grey,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardItem(BoardModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            '${model.title}',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 14.0,
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
        ],
      );
}
