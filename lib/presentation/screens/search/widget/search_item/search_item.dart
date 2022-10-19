import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';

class SearchItem extends StatelessWidget {

  final String? imagePath;
  final String title;
  final String price;
  final Function() onClickItem;

  const SearchItem({
    Key? key,
    this.imagePath,
    required this.title,
    required this.price,
    required this.onClickItem
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextTheme _textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onClickItem,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorConstant.white,
            boxShadow: [
              BoxShadow(
                  offset: const Offset(-1, 4),
                  blurRadius: 5,
                  color: Colors.grey.shade400
              )
            ]
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: SizedBox(
                width: 80,
                height: 80,
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
              )
            ),

            Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, right: 16, bottom: 16),
                  child: Column(
                    children: [
                      Flexible(
                          child: Align(
                            child: FittedBox(
                              child: Text(
                                title,
                                style: _textTheme.subtitle1?.copyWith(fontSize: 14),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            alignment: Alignment.topLeft,
                          )
                      ),
                      Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: RichText(
                              text: TextSpan(
                                  text: price,
                                  style: _textTheme.subtitle1?.copyWith(fontSize: 24, color: ColorConstant.blue),
                                  children: [
                                    TextSpan(
                                        text: '  บาท',
                                        style: _textTheme.subtitle1?.copyWith(fontSize: 20,)
                                    )
                                  ]
                              ),
                            ),
                          )
                      ),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
