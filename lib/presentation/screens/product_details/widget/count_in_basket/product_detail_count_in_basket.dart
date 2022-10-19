import 'package:flutter/material.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';

class ProductDetailCountItemInBasketWidget extends StatefulWidget {

  final Function() onClickIncrease;
  final Function() onClickDecrease;
  final int count;

  const ProductDetailCountItemInBasketWidget({Key? key, required this.onClickIncrease, required this.onClickDecrease, this.count = 1}) : super(key: key);

  @override
  State<ProductDetailCountItemInBasketWidget> createState() => _ProductDetailCountItemInBasketWidget();
}

class _ProductDetailCountItemInBasketWidget extends State<ProductDetailCountItemInBasketWidget> {
  @override
  Widget build(BuildContext context) {

    TextTheme _textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (widget.count > 1) ? () {
              widget.onClickDecrease();
            } : null,
            child: Opacity(
              opacity: (widget.count > 1) ? 1 : 0.4,
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 0),
                          blurRadius: 3,
                          color: Colors.grey.shade400
                      )
                    ],
                    image: const DecorationImage(
                        image: AssetImage('assets/icons/ic_minus.png')
                    )
                ),
              ),
            ),
          ),

          SizedBox(
              height: 60,
              width: 80,
              child: FittedBox(
                child: Text(
                  '${widget.count}',
                  style: _textTheme.subtitle1?.copyWith(fontSize: 32, color: ColorConstant.black),
                ),
              )
          ),

          GestureDetector(
            onTap: () {
              widget.onClickIncrease();
            },
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 0),
                        blurRadius: 3,
                        color: Colors.grey.shade400
                    )
                  ],
                  image: const DecorationImage(
                      image: AssetImage('assets/icons/ic_plus.png')
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}

