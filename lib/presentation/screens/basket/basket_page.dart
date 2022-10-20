import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';
import 'package:salaya_delivery_app/data/models/basket_object.dart';
import 'package:salaya_delivery_app/data/models/response/product.dart';
import 'package:salaya_delivery_app/data/models/shipping_type.dart';
import 'package:salaya_delivery_app/logic/bloc/basket/basket_bloc.dart';
import 'package:salaya_delivery_app/presentation/router/route_manager.dart';
import 'package:salaya_delivery_app/presentation/screens/basket/widget/basket_item.dart';
import 'package:salaya_delivery_app/presentation/utils/custom_appbar.dart';
import 'package:salaya_delivery_app/presentation/utils/function_basket.dart';
import 'package:salaya_delivery_app/presentation/utils/number_format_extension.dart';

class BasketPage extends StatefulWidget {
  const BasketPage({Key? key}) : super(key: key);

  @override
  State<BasketPage> createState() => _BasketPageState();
}

class _BasketPageState extends State<BasketPage> {
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
        child: Text(
          'ตะกร้าสินค้า',
          style: _textTheme.subtitle1?.copyWith(color: ColorConstant.white, fontSize: 20),
        )
      ),
      body: Stack(
        children: [

          Positioned.fill(
            child: BlocBuilder<BasketBloc, BasketState>(
              builder: (context, state) {
                if (state is BasketLoaded) {
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      BasketObject basket = state.items[index];
                      return Padding(
                          padding: EdgeInsets.only(top: (index == 0) ? 32 : 0, bottom: (index == (state.items.length - 1)) ? 150 : 0, left: 16, right: 16),
                          child: BasketItem(
                              imagePath: basket.product.images,
                              title: basket.product.productName,
                              price: basket.product.pricePerUnit,
                              count: basket.qty,
                              onClickRemove: () => showDialogAlertDelete(context, basket.product),
                              onClickDecrease: () => context.read<BasketBloc>().add(DecreaseBasket(product: basket.product)),
                              onClickIncrease: () => context.read<BasketBloc>().add(IncreaseBasket(product: basket.product))
                          )
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 16,),
                  );
                }
                return const Center(child: CircularProgressIndicator(),);
              }
            )
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: 130,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
              decoration: BoxDecoration(
                color: ColorConstant.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, -4),
                    blurRadius: 4,
                    color: Colors.grey.shade400
                  )
                ]
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ราคารวม',
                            style: _textTheme.subtitle1?.copyWith(fontSize: 28),
                          ),
                          Text(
                            '!! ราคานี้ยังไม่รวมค่าจัดส่งและค่าบริการ',
                            style: _textTheme.bodyText1?.copyWith(fontSize: 12, color: ColorConstant.yellow),
                          )
                        ],
                      ),
                      BlocBuilder<BasketBloc, BasketState>(
                        builder: (context, state) {
                          if (state is BasketLoaded) {
                            return FittedBox(
                              child: RichText(
                                text: TextSpan(
                                    text: generateCurrencyFormat(getTotalPriceInBasket(baskets: state.items)),
                                    style: _textTheme.subtitle1?.copyWith(fontSize: 28, color: ColorConstant.blue),
                                    children: [
                                      TextSpan(
                                          text: '  บาท',
                                          style: _textTheme.subtitle1?.copyWith(fontSize: 14, color: ColorConstant.black)
                                      )
                                    ]
                                ),
                              ),
                            );
                          }
                          return const Center(child: CircularProgressIndicator(),);
                        }
                      )

                    ],
                  ),
                  BlocBuilder<BasketBloc, BasketState>(
                    builder: (context, state) {
                      if (state is BasketLoaded) {
                        if (state.items.isNotEmpty) {
                          return ElevatedButton(
                              onPressed: () => showDialogSelectShipping(context),
                              child: const Text(
                                  "ซื้อสินค้า"
                              )
                          );
                        }
                        else {
                          return ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text(
                                  "กลับไปหน้าซื้อสินค้า"
                              )
                          );
                        }
                      }
                      return const SizedBox();
                    }
                  ),

                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

  Future<void> showDialogSelectShipping(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (_) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pushNamed(Routes.checkoutRoute, arguments: ShippingType.SHIPPING),
              child: const Center(child: Text('จัดส่งทางพัสดุไปรษณีย์'))
            ),
            const Divider(color: ColorConstant.grey, height: 1,),
            TextButton(
                onPressed: () => Navigator.of(context).pushNamed(Routes.checkoutRoute, arguments: ShippingType.DELIVERY),
                child: const Center(child: Text('จัดส่งภายใน 4 ชม.'))
            ),
            const Divider(color: ColorConstant.grey, height: 1,),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Center(child: Text('Cancel'))
            ),
          ],
        ),
      )
    );
  }

  Future<void> showDialogAlertDelete(BuildContext context, Product product) async {
    TextTheme _textTheme = Theme.of(context).textTheme;
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            'แจ้งเตือน',
            style: _textTheme.subtitle1?.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                product.productName,
                style: _textTheme.headline1?.copyWith(fontSize: 16, color: ColorConstant.blue),
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16,),
              Text(
                'คุณยืนยันที่จะลบหรือไม่ ?',
                style: _textTheme.subtitle1?.copyWith(fontSize: 14),
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  'ยกเลิก',
                  style: _textTheme.subtitle1?.copyWith(fontSize: 16),
                )
            ),
            TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                  context.read<BasketBloc>().add(RemoveBasket(product: product));
                },
                child: Text(
                  "ยืนยัน",
                  style: _textTheme.subtitle1?.copyWith(fontSize: 16, color: ColorConstant.blue),
                )
            )
          ],
        )
    );
  }
}
