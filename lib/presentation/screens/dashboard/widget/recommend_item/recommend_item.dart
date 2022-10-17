import 'package:flutter/material.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';

class RecommendItem extends StatelessWidget {

  final String imagePath;
  final String name;
  final double price;
  final Function() onClick;

  const RecommendItem({Key? key, required this.imagePath, required this.name, required this.price, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextTheme _textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onClick,
      child: Container(
          padding: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorConstant.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade400,
                  offset: const Offset(0, 3),
                  blurRadius: 3,
                )
              ]
          ),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(imagePath),
                      fit: BoxFit.cover
                    )
                  ),
                )
              ),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Align(
                          child: Text(
                            name,
                            style: _textTheme.bodyText1,
                            textAlign: TextAlign.center,
                          ),
                          alignment: Alignment.centerLeft,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: RichText(
                              text: TextSpan(
                                  text: '$price',
                                  style: _textTheme.headline1?.copyWith(fontSize: 20, color: ColorConstant.blue),
                                  children: [
                                    TextSpan(
                                      text: ' บาท',
                                      style: _textTheme.subtitle1?.copyWith(fontSize: 12),
                                    )
                                  ]
                              )
                          ),
                        )
                      ],
                    ),
                  )
              ),
            ],
          )
      ),
    );
  }
}
