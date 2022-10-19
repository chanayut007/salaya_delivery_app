import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';
import 'package:salaya_delivery_app/presentation/utils/number_format_extension.dart';

class CheckoutItem extends StatelessWidget {

  final String? imagePath;
  final String title;
  final double price;
  final int count;

  const CheckoutItem({
    Key? key,
    this.imagePath,
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
          SizedBox(
            width: 60,
            height: 60,
            child: Builder(
              builder: (context) {
                if (imagePath != null) {
                  return CachedNetworkImage(
                    imageUrl: imagePath!,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    placeholder: (context, url) => const Center(child: CircularProgressIndicator(),),
                    errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: const DecorationImage(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                  );
                }
                return Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: const DecorationImage(
                          image: AssetImage('assets/images/logo.png'),
                          fit: BoxFit.cover
                      )
                  ),
                );
              },
            ),
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
                    text: generatePrice(price * count),
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
