import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';
import 'package:salaya_delivery_app/presentation/screens/basket/widget/count_by_item.dart';


class BasketItem extends StatefulWidget {

  final String imagePath;
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

  final _countKey = GlobalKey<CountByItemWidgetState>();

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
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                      image: AssetImage(widget.imagePath),
                      fit: BoxFit.cover
                  )
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
                                  maxLines: 3,
                                  textAlign: TextAlign.start,
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                            ),
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
                                    text: '${widget.price * widget.count}',
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

                            CountByItemWidget(
                              key: _countKey,
                              onClickIncrease: widget.onClickIncrease,
                              onClickDecrease: widget.onClickDecrease
                            )

                            // SizedBox(
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     children: [
                            //       GestureDetector(
                            //         onTap: (count > 1) ? onClickMinus : null,
                            //         child: Opacity(
                            //           opacity: (count > 1) ? 1 : 0.2,
                            //           child: Container(
                            //             width: 20,
                            //             height: 20,
                            //             decoration: BoxDecoration(
                            //                 shape: BoxShape.circle,
                            //                 image: const DecorationImage(
                            //                   image: AssetImage('assets/icons/ic_minus.png'),
                            //                 ),
                            //                 boxShadow: [
                            //                   BoxShadow(
                            //                       offset: const Offset(0, 0),
                            //                       blurRadius: 3,
                            //                       color: Colors.grey.shade400
                            //                   )
                            //                 ]
                            //             ),
                            //           ),
                            //         )
                            //       ),
                            //       const SizedBox(width: 16,),
                            //       SizedBox(
                            //         width: 20,
                            //         height: 30,
                            //         child: FittedBox(
                            //           child: Text(
                            //             '$count',
                            //             style: _textTheme.subtitle1?.copyWith(fontSize: 32),
                            //           ),
                            //         ),
                            //       ),
                            //       const SizedBox(width: 16,),
                            //       GestureDetector(
                            //         onTap: onClickPlus,
                            //         child: Container(
                            //           width: 20,
                            //           height: 20,
                            //           decoration: BoxDecoration(
                            //               shape: BoxShape.circle,
                            //               image: const DecorationImage(
                            //                 image: AssetImage('assets/icons/ic_plus.png'),
                            //               ),
                            //               boxShadow: [
                            //                 BoxShadow(
                            //                     offset: const Offset(0, 0),
                            //                     blurRadius: 3,
                            //                     color: Colors.grey.shade400
                            //                 )
                            //               ]
                            //           ),
                            //         ),
                            //       ),
                            //
                            //     ],
                            //   ),
                            // )
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
