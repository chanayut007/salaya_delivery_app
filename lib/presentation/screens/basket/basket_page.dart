import 'package:flutter/material.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';
import 'package:salaya_delivery_app/data/models/shipping_type.dart';
import 'package:salaya_delivery_app/presentation/router/route_manager.dart';
import 'package:salaya_delivery_app/presentation/screens/basket/widget/basket_item.dart';
import 'package:salaya_delivery_app/presentation/utils/custom_appbar.dart';

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
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: 20,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: (index == 0) ? 32 : 0, bottom: (index == 19) ? 150 : 0, left: 16, right: 16),
                  child: BasketItem(
                    imagePath: 'assets/images/y1.png',
                    title: 'ยาเม็ดซาร่า (10 เม็ด)',
                    price: 12,
                    count: 1,
                    onClickRemove: () => showDialogAlertDelete(context, 'ยาเม็ดซาร่า (10 เม็ด)'),
                    onClickDecrease: (){},
                    onClickIncrease: (){}
                  )
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16,),
            ),
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
                      RichText(
                        text: TextSpan(
                          text: '12.00',
                          style: _textTheme.subtitle1?.copyWith(fontSize: 28, color: ColorConstant.blue),
                          children: [
                            TextSpan(
                              text: '  บาท',
                              style: _textTheme.subtitle1?.copyWith(fontSize: 14, color: ColorConstant.black)
                            )
                          ]
                        ),
                      )
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () => showDialogSelectShipping(context),
                    child: const Text(
                      "ซื้อสินค้า"
                    )
                  )
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

  Future<void> showDialogAlertDelete(BuildContext context, String title) async {
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
                title,
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
