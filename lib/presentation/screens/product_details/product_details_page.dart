import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';
import 'package:salaya_delivery_app/presentation/router/route_manager.dart';
import 'package:salaya_delivery_app/presentation/screens/product_details/widget/count_widget/count_widget.dart';
import 'package:salaya_delivery_app/presentation/utils/custom_appbar.dart';

class ProductDetailsPage extends StatefulWidget {

  final String productId;

  const ProductDetailsPage({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  @override
  Widget build(BuildContext context) {

    TextTheme _textTheme = Theme.of(context).textTheme;
    ElevatedButtonThemeData _buttonTheme = Theme.of(context).elevatedButtonTheme;

    final _countKey = GlobalKey<CountItemWidgetState>();

    return Scaffold(
      backgroundColor: ColorConstant.white,
      appBar: CustomAppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Container(
            padding: const EdgeInsets.all(14),
            child: const Image(
              image: AssetImage('assets/icons/ic_back.png'),
              width: 30,
              height: 30,
              fit: BoxFit.contain,
              color: ColorConstant.white,
            ),
          ),
        ),
        child: const Image(
          image: AssetImage('assets/images/logo.png'),
          width: 120,
          height: 55,
          fit: BoxFit.contain,
        ),
        trailing: [

          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(Routes.basketRoute);
            },
            child: Container(
                width: 35,
                height: 35,
                padding: const EdgeInsets.all(2),
                child: Badge(
                  badgeContent: Text(
                    '9',
                    style: _textTheme.subtitle1?.copyWith(color: ColorConstant.white),),
                  child: const Image(
                    image: AssetImage('assets/icons/ic_basket.png'),
                  ),
                  position: BadgePosition.topEnd(top: 5),
                  animationType: BadgeAnimationType.scale,
                  showBadge: true,
                )
            ),
          ),

          const SizedBox(width: 16,),
        ],
      ),
      body: Column(
        children: [
          const Expanded(
            flex: 3,
            child: Image(
              image: AssetImage('assets/images/y1.png'),
            )
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                children: [
                  const SizedBox(height: 24,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ยาเม็ดซาร่า (10 เม็ด)',
                      style: _textTheme.subtitle1?.copyWith(fontSize: 24),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                      text: TextSpan(
                        text: "12",
                        style: _textTheme.subtitle1?.copyWith(fontSize: 24, color: ColorConstant.blue),
                        children: [
                          TextSpan(
                            text: '  บาท',
                            style: _textTheme.subtitle1?.copyWith(fontSize: 24)
                          )
                        ]
                      )
                    )
                  ),

                  const SizedBox(height: 8,),

                  Divider(height: 5, color: Colors.grey.shade600,),

                  SizedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        children: [
                          const SizedBox(height: 8,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'รายละเอียดสินค้า',
                              style: _textTheme.subtitle1?.copyWith(fontSize: 14, color: ColorConstant.blue),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              '- บรรเทาอาการปวด ลดไข้',
                              style: _textTheme.subtitle1?.copyWith(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ],
              ),
            )
          ),

          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Divider(height: 5, color: Colors.grey.shade600,)
              )
          ),

          SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                children: [
                  CountItemWidget(
                    key: _countKey,
                    onClickIncrease: () {},
                    onClickDecrease: () {}
                  ),
                  ElevatedButton(
                      style: _buttonTheme.style?.copyWith(
                          backgroundColor: MaterialStateProperty.all<Color>(ColorConstant.primary),
                          elevation: MaterialStateProperty.all<double>(5)
                      ),
                      onPressed: (){},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'ใส่ตะกร้า',
                            style: _textTheme.subtitle1?.copyWith(fontSize: 24, color: ColorConstant.white),
                          ),
                          const SizedBox(width: 8,),
                          const Image(
                            image: AssetImage('assets/icons/ic_basket.png'),
                            height: 30,
                            width: 30,
                          )
                        ],
                      )
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
