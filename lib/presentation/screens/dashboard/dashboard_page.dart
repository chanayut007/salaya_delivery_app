import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';
import 'package:salaya_delivery_app/data/models/basket_object.dart';
import 'package:salaya_delivery_app/data/models/category_widget_input.dart';
import 'package:salaya_delivery_app/data/models/response/product.dart';
import 'package:salaya_delivery_app/data/repositories/remote/remote_category_repository.dart';
import 'package:salaya_delivery_app/data/repositories/remote/remote_product_repository.dart';
import 'package:salaya_delivery_app/logic/bloc/basket/basket_bloc.dart';
import 'package:salaya_delivery_app/logic/bloc/branch/branch_bloc.dart';
import 'package:salaya_delivery_app/logic/bloc/category/category_bloc.dart';
import 'package:salaya_delivery_app/logic/bloc/recommend/recommend_bloc.dart';
import 'package:salaya_delivery_app/presentation/router/route_manager.dart';
import 'package:salaya_delivery_app/presentation/screens/dashboard/widget/category/category_item.dart';
import 'package:salaya_delivery_app/presentation/screens/dashboard/widget/recommend_item/recommend_item.dart';
import 'package:salaya_delivery_app/presentation/utils/custom_appbar.dart';
import 'package:salaya_delivery_app/presentation/utils/function_basket.dart';
import 'package:salaya_delivery_app/presentation/utils/number_format_extension.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(create: (context) => CategoryBloc(
            remoteCategoryRepository: context.read<RemoteCategoryRepository>())),

        BlocProvider<RecommendBloc>(create: (context) => RecommendBloc(
            remoteProductRepository: context.read<RemoteProductRepository>())),

      ],
      child: Scaffold(
          appBar: CustomAppBar(
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
                        return const Center(child: CircularProgressIndicator());
                      }
                    )
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
                                  'จัดส่งจาก',
                                  style: _textTheme.subtitle1?.copyWith(fontSize: 16),
                                ),

                                const SizedBox(height: 8,),

                                Expanded(
                                    child: BlocBuilder<BranchBloc, BranchState>(
                                      builder: (context, state) {
                                        String text = "";
                                        if (state is BranchInitial) {
                                          context.read<BranchBloc>().add(GetBranchShipping());
                                          text = "กำลังค้นหา...";
                                        }
                                        else if (state is BranchLoading) {
                                          text = "กำลังค้นหา...";
                                        }
                                        else if (state is BranchLoaded) {
                                          text = state.branch.branchName;
                                        }
                                        else if (state is BranchError) {
                                          text = state.message;
                                        }
                                        return FittedBox(
                                          child: Text(
                                            text,
                                            style: _textTheme.subtitle1?.copyWith(fontSize: 24, color: ColorConstant.secondary),
                                          ),
                                        );
                                      },
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
                    child: BlocBuilder<CategoryBloc, CategoryState>(
                      builder: (context, state) {
                        if (state is CategoryInitial) {
                          context.read<CategoryBloc>().add(GetCategory());
                          return Container();
                        }

                        else if (state is CategoryLoading) {
                          return const Center(child: CircularProgressIndicator(),);
                        }

                        else if (state is CategoryLoaded) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              (state.categoryAllProduct != null)
                              ? CategoryItem(
                                imagePath: 'assets/images/category_all.png',
                                title: 'แสดงทั้งหมด',
                                onClick: () {
                                  Navigator.of(context).pushNamed(
                                      Routes.categoryRoute,
                                      arguments: CategoryWidgetInput(
                                          title: 'แสดงทั้งหมด',
                                          categoryId: state.categoryAllProduct!.categoryId
                                      )
                                  );
                                },
                              )
                              : const Opacity(
                                opacity: 0.3,
                                child: CategoryItem(
                                  imagePath: 'assets/images/category_all.png',
                                  title: 'แสดงทั้งหมด',
                                  onClick: null,
                                ),
                              ),

                              (state.categoryCosmetics != null)
                              ? CategoryItem(
                                imagePath: 'assets/images/category_1.png',
                                title: "เวชสำอาง",
                                onClick: () {
                                  Navigator.of(context).pushNamed(
                                    Routes.categoryRoute,
                                    arguments: CategoryWidgetInput(
                                      title: 'เวชสำอาง',
                                      categoryId: state.categoryCosmetics!.categoryId
                                    )
                                  );
                                } ,
                              )
                              : const Opacity(
                                opacity: 0.3,
                                child: CategoryItem(
                                  imagePath: 'assets/images/category_1.png',
                                  title: "เวชสำอาง",
                                  onClick: null ,
                                ),
                              ),

                              (state.categoryHealthCareEquipment != null)
                              ? CategoryItem(
                                imagePath: 'assets/images/category_2.png',
                                title: 'อุปกรณ์ดูแลสุขภาพ',
                                onClick: () {
                                  Navigator.of(context).pushNamed(
                                    Routes.categoryRoute,
                                    arguments: CategoryWidgetInput(
                                      title: 'อุปกรณ์ดูแลสุขภาพ',
                                      categoryId: state.categoryHealthCareEquipment!.categoryId
                                    )
                                  );
                                },
                              )
                              : const Opacity(
                                opacity: 0.3,
                                child: CategoryItem(
                                  imagePath: 'assets/images/category_2.png',
                                  title: 'อุปกรณ์ดูแลสุขภาพ',
                                  onClick: null
                                ),
                              )

                            ],
                          );
                        }

                        else if (state is CategoryError) {
                          return Center(
                            child: Text(
                              state.message,
                              style: _textTheme.bodyText1,
                            ),
                          );
                        }
                        return Container();
                      }
                    )
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
                    child: BlocBuilder<RecommendBloc, RecommendState>(
                      builder: (context, state) {
                        if (state is RecommendInitial) {
                          context.read<RecommendBloc>().add(GetProductRecommend());
                          return const Center(child: CircularProgressIndicator(),);
                        }
                        else if (state is RecommendLoading) {
                          return const Center(child: CircularProgressIndicator(),);
                        }
                        else if (state is RecommendLoaded) {
                          return GridView.builder(
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
                          );
                        }
                        else if (state is RecommendError) {
                          return Center(
                            child: Text(
                              state.message,
                              style: _textTheme.bodyText1,
                            ),
                          );
                        }
                        return Container();
                      }
                    )
                  )
              )
            ],
          )
      )
    );
  }
}
