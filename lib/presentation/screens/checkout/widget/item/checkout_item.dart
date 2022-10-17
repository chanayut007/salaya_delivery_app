import 'package:flutter/material.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';

class CheckoutItem extends StatelessWidget {

  final String imagePath;
  final String title;
  final String price;
  final int count;

  const CheckoutItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.count
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextTheme _textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(imagePath),
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 8,),
          Expanded(
              child: Text(
                title,
                style: _textTheme.bodyText1?.copyWith(fontSize: 12),
              )
          ),
          const SizedBox(width: 8,),
          Column(
            children: [
              RichText(
                text: TextSpan(
                    text: price,
                    style: _textTheme.bodyText1?.copyWith(fontSize: 16, color: ColorConstant.blue),
                    children: [
                      TextSpan(
                          text: '  บาท',
                          style: _textTheme.bodyText1?.copyWith(fontSize: 16)
                      )
                    ]
                ),
              ),
              Text(
                'x$count',
                style: _textTheme.bodyText1?.copyWith(fontSize: 16),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
          )
        ],
      ),
    );
  }
}
