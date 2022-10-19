import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';
import 'package:salaya_delivery_app/data/models/category_widget_input.dart';
import 'package:salaya_delivery_app/data/models/response/product.dart';
import 'package:salaya_delivery_app/data/repositories/remote/remote_product_repository.dart';
import 'package:salaya_delivery_app/logic/bloc/basket/basket_bloc.dart';
import 'package:salaya_delivery_app/logic/bloc/product_category/product_category_bloc.dart';
import 'package:salaya_delivery_app/presentation/router/route_manager.dart';
import 'package:salaya_delivery_app/presentation/utils/custom_appbar.dart';
import 'package:salaya_delivery_app/presentation/utils/function_basket.dart';
import 'package:salaya_delivery_app/presentation/utils/number_format_extension.dart';

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

    return BlocProvider<ProductCategoryBloc>(
      create: (context) => ProductCategoryBloc(
        remoteProductRepository: context.read<RemoteProductRepository>()),
      child: Scaffold(
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
                    child: BlocBuilder<BasketBloc, BasketState>(
                        builder: (context, state) {
                          if (state is BasketLoaded) {
                            int count = getTotalCountInBasket(baskets: state.items);
                            return Badge(
                              badgeContent: Text(
                                '$count',
                                style: _textTheme.subtitle1?.copyWith(color: ColorConstant.white),),
                              child: const Image(
                                image: AssetImage('assets/icons/ic_basket.png'),
                              ),
                              position: BadgePosition.topEnd(top: 5),
                              animationType: BadgeAnimationType.scale,
                              showBadge: (count > 0) ? true : false,
                            );
                          }
                          return const Center(child: CircularProgressIndicator(),);
                        }
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
        body: BlocBuilder<ProductCategoryBloc, ProductCategoryState>(
          builder: (context, state) {
            if (state is ProductCategoryInitial) {
              context.read<ProductCategoryBloc>().add(GetProductByCategoryId(categoryId: input.categoryId));
              return Container();
            }
            else if (state is ProductCategoryLoading) {
              return const Center(child: CircularProgressIndicator(),);
            }
            else if (state is ProductCategoryLoaded) {
              return Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
                child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 180,
                      childAspectRatio: 3/4,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                    ),
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      Product product = state.products[index];
                      return Padding(
                          padding: EdgeInsets.only(left: (index.isOdd) ? 0: 16, right: (index.isEven)? 0 : 16),
                          child: RecommendItem(
                              imagePath: product.images,
                              name: product.productName,
                              price: generatePrice(product.pricePerUnit),
                              onClick: ()=> Navigator.of(context).pushNamed(Routes.productDetailsRoute, arguments: product.productId)
                          )
                      );
                    }
                ),
              );
            }
            else if (state is ProductCategoryError) {
              return Center(
                child: Text(
                  state.message,
                  style: _textTheme.bodyText1,
                ),
              );
            }
            return Container();
          }
        ),
      ),
    );
  }
}
