import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';
import 'package:salaya_delivery_app/data/models/category_widget_input.dart';
import 'package:salaya_delivery_app/presentation/router/route_manager.dart';
import 'package:salaya_delivery_app/presentation/utils/custom_appbar.dart';

import '../dashboard/widget/recommend_item/recommend_item.dart';

class CategoryPage extends StatefulWidget {

  final CategoryWidgetInput? input;

  const CategoryPage({Key? key, this.input}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  late CategoryWidgetInput input;

  @override
  void initState() {
    super.initState();
    if (widget.input != null) {
      input = widget.input!;
    } else {
      input = const CategoryWidgetInput(title: 'สินค้าทั้งหมด', categoryId: 'all');
    }
  }

  @override
  Widget build(BuildContext context) {

    TextTheme _textTheme = Theme.of(context).textTheme;

    return Scaffold(
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
          child: Text(
            input.title,
            style: _textTheme.subtitle1?.copyWith(color: ColorConstant.white, fontSize: 20),
          )
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 180,
              childAspectRatio: 3/4,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            physics: const BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                  padding: EdgeInsets.only(left: (index.isOdd) ? 0: 16, right: (index.isEven)? 0 : 16),
                  child: RecommendItem(
                      imagePath: 'assets/images/y1.png',
                      name: 'ยาเม็ดซาร่า',
                      price: 12,
                      onClick: ()=> Navigator.of(context).pushNamed(Routes.productDetailsRoute, arguments: '1234')
                  )
              );
            }
        ),
      ),
    );
  }
}
