import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';
import 'package:salaya_delivery_app/logic/bloc/basket/basket_bloc.dart';
import 'package:salaya_delivery_app/presentation/screens/basket/widget/count_by_item.dart';
import 'package:salaya_delivery_app/presentation/utils/number_format_extension.dart';


class BasketItem extends StatefulWidget {

  final String? imagePath;
  final String title;
  final double price;
  final int count;
  final Function() onClickRemove;
  final Function() onClickDecrease;
  final Function() onClickIncrease;

  const BasketItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.price,
    required this.count,
    required this.onClickRemove,
    required this.onClickDecrease,
    required this.onClickIncrease
  }) : super(key: key);

  @override
  State<BasketItem> createState() => _BasketItemState();
}

class _BasketItemState extends State<BasketItem> {

  // final _countKey = GlobalKey<CountByItemWidgetState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    TextTheme _textTheme = Theme.of(context).textTheme;

    return Container(
        width: double.maxFinite,
        height: 130,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            color: ColorConstant.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(1, 3),
                  blurRadius: 4,
                  color: Colors.grey.shade400
              )
            ]
        ),
        child: Row(
          children: [
            const SizedBox(width: 8,),
            SizedBox(
              width: 100,
              height: 100,
              child: Builder(
                builder: (context) {
                  if (widget.imagePath != null) {
                    return CachedNetworkImage(
                      imageUrl: widget.imagePath!,
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
                child: Column(
                  children: [
                    Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Expanded(
                              child: Align(
                                child: Text(
                                  widget.title,
                                  style: _textTheme.bodyText1?.copyWith(fontSize: 14),
                                  maxLines: 2,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ),

                            const SizedBox(width: 16,),

                            Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: widget.onClickRemove,
                                child: const Image(
                                  image: AssetImage('assets/icons/ic_trash.png'),
                                  width: 25,
                                  height: 25,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                          ],
                        )
                    ),
                    Expanded(
                        flex: 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                    text: generatePrice(widget.price * widget.count),
                                    style: _textTheme.subtitle1?.copyWith(fontSize: 28, color: ColorConstant.blue),
                                    children: [
                                      TextSpan(
                                          text: '  บาท',
                                          style: _textTheme.subtitle1?.copyWith(fontSize: 16)
                                      )
                                    ]
                                ),
                              ),
                            ),

                            CountItemInBasketWidget(
                              onClickIncrease: widget.onClickIncrease,
                              onClickDecrease: widget.onClickDecrease,
                              count: widget.count,
                            ),
                            
                          ],
                        )
                    ),
                  ],
                )
            ),
            const SizedBox(width: 24,)
          ],
        )
    );
  }
}
