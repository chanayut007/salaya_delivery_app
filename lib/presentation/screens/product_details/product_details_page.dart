import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';
import 'package:salaya_delivery_app/data/models/basket_object.dart';
import 'package:salaya_delivery_app/data/models/response/product.dart';
import 'package:salaya_delivery_app/data/repositories/remote/remote_product_repository.dart';
import 'package:salaya_delivery_app/logic/bloc/basket/basket_bloc.dart';
import 'package:salaya_delivery_app/logic/bloc/product_detail/product_detail_bloc.dart';
import 'package:salaya_delivery_app/presentation/router/route_manager.dart';
import 'package:salaya_delivery_app/presentation/screens/product_details/widget/count_in_basket/product_detail_count_in_basket.dart';
import 'package:salaya_delivery_app/presentation/screens/product_details/widget/count_widget/product_detail_count_widget.dart';
import 'package:salaya_delivery_app/presentation/utils/custom_appbar.dart';
import 'package:salaya_delivery_app/presentation/utils/function_basket.dart';
import 'package:salaya_delivery_app/presentation/utils/number_format_extension.dart';

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

    final _countKey = GlobalKey<ProductDetailCountItemWidgetState>();

    return BlocProvider<ProductDetailBloc>(
      create: (context) => ProductDetailBloc(
          remoteProductRepository: context.read<RemoteProductRepository>()),
      child: Scaffold(
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
                  child: BlocBuilder<BasketBloc, BasketState>(
                      builder: (context, state) {
                        if (state is BasketLoaded) {
                          int count = getTotalCountInBasket(baskets: state.items);
                          return Badge(
                            badgeContent: Text(
                              '$count',
                              style: _textTheme.subtitle1?.copyWith(color: ColorConstant.white),
                            ),
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
        body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, productDetailState) {
            if (productDetailState is ProductDetailInitial) {
              context.read<ProductDetailBloc>().add(GetProductDetailById(productId: widget.productId));
              return Container();
            }
            else if (productDetailState is ProductDetailLoading) {
              return const Center(child: CircularProgressIndicator(),);
            }
            else if (productDetailState is ProductDetailLoaded) {
              return Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Builder(
                        builder: (context) {
                          if (productDetailState.productDetail.images != null) {
                            return CachedNetworkImage(
                              imageUrl: productDetailState.productDetail.images!,
                              imageBuilder: (context, imageProvider) => Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.contain
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
                                productDetailState.productDetail.productName,
                                style: _textTheme.subtitle1?.copyWith(fontSize: 24),
                              ),
                            ),
                            Align(
                                alignment: Alignment.centerLeft,
                                child: RichText(
                                    text: TextSpan(
                                        text: generatePrice(productDetailState.productDetail.pricePerUnit),
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
                                        '- ${productDetailState.productDetail.details}',
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
                          SizedBox(
                            height: 70,
                            child: BlocBuilder<BasketBloc, BasketState>(
                              builder: (context, state) {
                                if (state is BasketLoaded) {
                                  final products = state.items.where((element) => element.product.productId == productDetailState.productDetail.productId).toList();
                                  if (products.isNotEmpty) {
                                    return ProductDetailCountItemInBasketWidget(
                                      onClickIncrease: () => context.read<BasketBloc>().add(IncreaseBasket(product: products.first.product)),
                                      onClickDecrease: () => context.read<BasketBloc>().add(DecreaseBasket(product: products.first.product)),
                                      count: products.first.qty,
                                    );
                                  }
                                  else {
                                    return ProductDetailCountItemWidget(
                                      key: _countKey,
                                      onClickIncrease: () {},
                                      onClickDecrease: () {},
                                    );
                                  }
                                }
                                return Container();
                              }
                            ),
                          ),

                          SizedBox(
                            height: 50,
                            child: BlocBuilder<BasketBloc, BasketState>(
                              builder: (context, state) {
                                if (state is BasketLoaded) {
                                  final products = state.items.where((element) => element.product.productId == productDetailState.productDetail.productId).toList();
                                  if (products.isNotEmpty) {
                                    return Container(
                                      height: 50,
                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(100),
                                          color: Colors.green.shade900
                                      ),
                                      child: Text(
                                        'อยู่ในตะกร้าเรียบร้อยแล้ว',
                                        style: _textTheme.subtitle1?.copyWith(fontSize: 24, color: ColorConstant.white),
                                      ),
                                    );
                                  }
                                  else {
                                    return ElevatedButton(
                                        style: _buttonTheme.style?.copyWith(
                                            backgroundColor: MaterialStateProperty.all<Color>(ColorConstant.primary),
                                            elevation: MaterialStateProperty.all<double>(5)
                                        ),
                                        onPressed: (){
                                          context.read<BasketBloc>().add(
                                              AddBasket(
                                                  qty: _countKey.currentState!.count,
                                                  product: Product(
                                                      productId: productDetailState.productDetail.productId,
                                                      productName: productDetailState.productDetail.productName,
                                                      images: productDetailState.productDetail.images,
                                                      pricePerUnit: productDetailState.productDetail.pricePerUnit
                                                  )
                                              )
                                          );
                                        },
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
                                    );
                                  }
                                }
                                return ElevatedButton(
                                    style: _buttonTheme.style?.copyWith(
                                        backgroundColor: MaterialStateProperty.all<Color>(ColorConstant.primary),
                                        elevation: MaterialStateProperty.all<double>(5)
                                    ),
                                    onPressed: (){
                                      context.read<BasketBloc>().add(
                                          AddBasket(
                                              qty: _countKey.currentState!.count,
                                              product: Product(
                                                  productId: productDetailState.productDetail.productId,
                                                  productName: productDetailState.productDetail.productName,
                                                  images: productDetailState.productDetail.images,
                                                  pricePerUnit: productDetailState.productDetail.pricePerUnit
                                              )
                                          )
                                      );
                                    },
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
                                );
                              }
                            ),
                          )

                        ],
                      ),
                    ),
                  ),
                ],
              );
            }
            else if (productDetailState is ProductDetailError) {
              return Center(
                child: Text(
                  productDetailState.message,
                  style: _textTheme.bodyText1,
                ),
              );
            }
            return Container();
          }
        )
      ),
    );
  }
}
