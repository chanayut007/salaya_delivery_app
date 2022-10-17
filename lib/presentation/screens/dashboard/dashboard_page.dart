import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';
import 'package:salaya_delivery_app/data/models/category_widget_input.dart';
import 'package:salaya_delivery_app/presentation/router/route_manager.dart';
import 'package:salaya_delivery_app/presentation/screens/dashboard/widget/category/category_item.dart';
import 'package:salaya_delivery_app/presentation/screens/dashboard/widget/recommend_item/recommend_item.dart';
import 'package:salaya_delivery_app/presentation/utils/custom_appbar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(
        leading: Container(
          padding: const EdgeInsets.all(14),
          child: const Image(
            image: AssetImage('assets/icons/ic_home.png'),
            width: 30,
            height: 30,
            fit: BoxFit.contain,
            color: ColorConstant.white,
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

          GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(2),
              width: 35,
              height: 35,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorConstant.white
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorConstant.blue
                ),
                child: const Icon(Icons.person, size: 20, color: ColorConstant.white,),
              ),
            ),
          ),

          const SizedBox(width: 16,),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 16,),
          SizedBox(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const SizedBox(
                    width: 100,
                    height: 80,
                    child: Image(
                      image: AssetImage('assets/images/delivery.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(width: 16,),
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'จัดส่งที่',
                            style: _textTheme.subtitle1?.copyWith(fontSize: 16),
                          ),

                          const SizedBox(height: 8,),

                          Expanded(
                              child: Text(
                                'หอบ้านเบญจรงค์ 81/1 ถนน ราชมรรคา',
                                style: _textTheme.subtitle1?.copyWith(fontSize: 16, color: ColorConstant.secondary),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              )
                          )
                        ],
                      )
                  )
                ],
              ),
            )
          ),
          const SizedBox(height: 16,),
          SizedBox(
            height: 60,
            child: InkWell(
              onTap: () => Navigator.of(context).pushNamed(Routes.searchRoute),
              borderRadius: BorderRadius.circular(100),
              child: Container(
                alignment: Alignment.center,
                width: size.width * 0.8,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                height: 60,
                decoration: BoxDecoration(
                  color: ColorConstant.white,
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade400,
                      offset: const Offset(0, 3),
                      blurRadius: 3,
                    )
                  ]
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Image(
                      image: AssetImage('assets/icons/ic_search.png'),
                      color: ColorConstant.secondary,
                      width: 30,
                      height: 30,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 32,),
                    Text(
                      'ค้นหายา',
                      style: _textTheme.caption?.copyWith(color: ColorConstant.grey, fontSize: 18),
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16,),
          SizedBox(
            height: 124,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        CategoryItem(
                          imagePath: 'assets/images/category_all.png',
                          title: 'สินค้าทั้งหมด',
                          onClick: () => Navigator.of(context).pushNamed(Routes.categoryRoute)
                        ),
                        CategoryItem(
                            imagePath: 'assets/images/category_1.png',
                            title: 'เวชสำอาง',
                            onClick: () => Navigator.of(context).pushNamed(Routes.categoryRoute, arguments: const CategoryWidgetInput(title: 'เวชสำอาง', categoryId: '1234'))
                        ),
                        CategoryItem(
                            imagePath: 'assets/images/category_2.png',
                            title: 'อุปกรณ์ดูแลสุขภาพ',
                            onClick: () => Navigator.of(context).pushNamed(Routes.categoryRoute, arguments: const CategoryWidgetInput(title: 'อุปกรณ์ดูแลสุขภาพ', categoryId: '1234'))
                        ),

                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16,),
          SizedBox(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'แนะนำยาประจำวัน',
                  style: _textTheme.subtitle1?.copyWith(fontSize: 16, color: ColorConstant.secondary),
                  textAlign: TextAlign.start,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
            )
          )
        ],
      )
    );
  }
}
