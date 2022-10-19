import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';
import 'package:salaya_delivery_app/data/models/response/product.dart';
import 'package:salaya_delivery_app/data/repositories/local/local_product_repository.dart';
import 'package:salaya_delivery_app/data/repositories/remote/remote_product_repository.dart';
import 'package:salaya_delivery_app/logic/bloc/basket/basket_bloc.dart';
import 'package:salaya_delivery_app/logic/bloc/search/search_bloc.dart';
import 'package:salaya_delivery_app/presentation/router/route_manager.dart';
import 'package:salaya_delivery_app/presentation/screens/search/widget/search_item/search_item.dart';
import 'package:salaya_delivery_app/presentation/utils/custom_appbar.dart';
import 'package:salaya_delivery_app/presentation/utils/function_basket.dart';
import 'package:salaya_delivery_app/presentation/utils/number_format_extension.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  final TextEditingController _controllerSearch = TextEditingController();
  final FocusNode _focusNodeSearch = FocusNode();

  @override
  void dispose() {
    _focusNodeSearch.dispose();
    _controllerSearch.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    TextTheme _textTheme = Theme.of(context).textTheme;

    return BlocProvider<SearchBloc>(
      create: (context) => SearchBloc(
        remoteProductRepository: context.read<RemoteProductRepository>(),
        localProductRepository: context.read<LocalProductRepository>()
      ),
      child: BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {
          if (state is NavigateToProductDetailPage) {
            Navigator.of(context).pushNamed(Routes.productDetailsRoute, arguments: state.productId);
          }
        },
        child: GestureDetector(
          onTap: () => unFocusTextField(),
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
                    'ค้นหายา',
                    style: _textTheme.subtitle1?.copyWith(color: ColorConstant.white, fontSize: 20),
                  )
              ),
              body: Column(
                children: [
                  SizedBox(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                        child: BlocBuilder<SearchBloc, SearchState>(
                            builder: (context, state) {
                              return TextField(
                                controller: _controllerSearch,
                                focusNode: _focusNodeSearch,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                                  hintText: 'ค้นหายา',
                                  hintStyle: _textTheme.subtitle1?.copyWith(fontSize: 18),
                                  prefixIcon: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: const [
                                      SizedBox(
                                        width: 16,
                                      ),
                                      Image(
                                        image: AssetImage('assets/icons/ic_search.png'),
                                        width: 30,
                                        height: 30,
                                        fit: BoxFit.cover,
                                        color: ColorConstant.secondary,
                                      ),
                                      SizedBox(
                                        width: 16,
                                      ),
                                    ],
                                  ),
                                ),
                                onChanged: (value) {
                                  if (value.isNotEmpty) {
                                    context.read<SearchBloc>().add(SearchProductByKeyword(keyword: value));
                                  } else {
                                    context.read<SearchBloc>().add(SearchProductLocal());
                                  }
                                },
                                cursorColor: ColorConstant.black,
                                style: _textTheme.bodyText1?.copyWith(fontSize: 18),
                              );
                            }
                        )
                    ),
                  ),
                  const SizedBox(height: 16,),
                  Expanded(
                      child: BlocBuilder<SearchBloc, SearchState>(
                          builder: (context, state) {
                            if (state is SearchInitial) {
                              context.read<SearchBloc>().add(SearchProductLocal());
                              return Container();
                            }
                            else if (state is SearchLoading) {
                              return const Center(child: CircularProgressIndicator(),);
                            }
                            else if (state is SearchLoaded) {
                              if (state.products.isNotEmpty) {
                                return ListView.separated(
                                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                                  itemCount: state.products.length,
                                  itemBuilder: (context, index) {
                                    Product product = state.products[index];
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 24),
                                      child: SearchItem(
                                          onClickItem: () {
                                            unFocusTextField();
                                            context.read<SearchBloc>().add(SaveProductToLocal(product: product));
                                          },
                                          imagePath: product.images,
                                          title: product.productName,
                                          price: generatePrice(product.pricePerUnit)
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) => const SizedBox(height: 16,),
                                );
                              }
                              return Center(
                                child: Text(
                                  'ไม่มีสินค้าที่ค้นหา',
                                  style: _textTheme.bodyText1,
                                ),
                              );
                            }
                            else if (state is SearchError) {
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
                ],
              )
          ),
        ),
      )
    );
  }

  void unFocusTextField() => FocusManager.instance.primaryFocus?.unfocus();
}
