import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';

class RecommendItem extends StatelessWidget {

  final String? imagePath;
  final String name;
  final String price;
  final Function() onClick;

  const RecommendItem({Key? key, this.imagePath, required this.name, required this.price, required this.onClick}) : super(key: key);

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
                )
              ),
              const SizedBox(height: 8,),
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          child: Text(
                            name,
                            style: _textTheme.subtitle1?.copyWith(fontSize: 10),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          alignment: Alignment.topLeft,
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: RichText(
                              text: TextSpan(
                                  text: price,
                                  style: _textTheme.headline1?.copyWith(fontSize: 15, color: ColorConstant.blue),
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
