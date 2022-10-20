

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';
import 'package:salaya_delivery_app/core/constants/value_constant.dart';
import 'package:salaya_delivery_app/data/models/basket_object.dart';
import 'package:salaya_delivery_app/data/models/shipping_type.dart';
import 'package:salaya_delivery_app/data/repositories/remote/remote_checkout_repository.dart';
import 'package:salaya_delivery_app/logic/bloc/basket/basket_bloc.dart';
import 'package:salaya_delivery_app/logic/bloc/branch/branch_bloc.dart';
import 'package:salaya_delivery_app/logic/bloc/checkout/checkout_bloc.dart';
import 'package:salaya_delivery_app/presentation/router/route_manager.dart';
import 'package:salaya_delivery_app/presentation/screens/checkout/widget/item/checkout_item.dart';
import 'package:salaya_delivery_app/presentation/screens/pdf/pdf_page.dart';
import 'package:salaya_delivery_app/presentation/utils/function_basket.dart';
import 'package:salaya_delivery_app/presentation/utils/number_format_extension.dart';
import 'package:salaya_delivery_app/presentation/utils/permission_handler.dart';

class CheckoutPage extends StatefulWidget {

  final ShippingType shippingType;

  const CheckoutPage({
    Key? key,
    required this.shippingType
  }) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {

  // 'หอบ้านเบญจรงค์ 81/1 ถนน ราชมรรคา ตำบล สนามจันทร์ อำเภอ เมือง นครปฐม 73000 ประเทศไทย'
  // วางไว่ใต้หอ
  late TextEditingController _controllerAddress;
  late TextEditingController _controllerComment;
  late TextEditingController _controllerFullName;
  late TextEditingController _controllerPhoneNumber;


  late FocusNode _focusNodeAddress;
  late FocusNode _focusNodeComment;
  late FocusNode _focusNodeFullName;
  late FocusNode _focusNodePhoneNumber;

  @override
  void initState() {
    super.initState();
    _controllerAddress = TextEditingController();
    _controllerComment = TextEditingController();
    _controllerFullName = TextEditingController();
    _controllerPhoneNumber = TextEditingController();

    _focusNodeAddress = FocusNode();
    _focusNodeComment = FocusNode();
    _focusNodeFullName = FocusNode();
    _focusNodePhoneNumber = FocusNode();
  }

  @override
  void dispose() {
    _controllerAddress.dispose();
    _controllerFullName.dispose();
    _controllerPhoneNumber.dispose();
    _controllerComment.dispose();

    _focusNodeAddress.dispose();
    _focusNodeFullName.dispose();
    _focusNodePhoneNumber.dispose();
    _focusNodeComment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    TextTheme _textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;

    return BlocProvider<CheckoutBloc>(
      create: (context) => CheckoutBloc(
        remoteCheckoutRepository: context.read<RemoteCheckoutRepository>(),
        shippingType: widget.shippingType
      ),
      child: BlocListener<CheckoutBloc, CheckoutState>(
        listener: (context, state) async {
          if (state is CheckoutApiLoading) {
            //Todo : showLoading
            showLoading(context);
          }
          else if (state is CheckoutApiSuccess) {
            //Todo : create pdf file and navigate to dashboard page
            debugPrint("Start Generate file");
            await PdfOrderApi.generate(state.order);
            context.read<BasketBloc>().add(RemoveAllBasket());
            hideLoading(context);

            Navigator.of(context).pushNamedAndRemoveUntil(Routes.dashboardRoute, (route) => false, arguments: true);
          }
          else if (state is CheckoutApiError) {
            //Todo : show error dialog
            hideLoading(context);
            showErrorDialog(context: context, message: state.message);
          }
        },
        child: WillPopScope(
          onWillPop: () async {
            return showDialogAlertBackToHome(context);
          },
          child: GestureDetector(
            onTap: () => unFocusTextField(),
            child: Scaffold(
                backgroundColor: ColorConstant.white,
                extendBodyBehindAppBar: true,
                body: Stack(
                  children: [
                    Positioned.fill(
                      child: Column(
                        children: [
                          SizedBox(
                            width: size.width,
                            height: 300,
                            child: Stack(
                              children: [
                                Positioned(
                                  child: SizedBox(
                                    height: 80,
                                    child: Container(
                                        color: ColorConstant.primary,
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              left: 0,
                                              right: 0,
                                              bottom: 16,
                                              child: Text(
                                                'สั่งซื้อสินค้า',
                                                style: _textTheme.headline1?.copyWith(fontSize: 20, color: ColorConstant.white),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 5,
                                              left: 0,
                                              child: GestureDetector(
                                                onTap: () async{
                                                  await showDialogAlertBackToHome(context);
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.all(14),
                                                  child: const Center(
                                                    child: Image(
                                                      image: AssetImage('assets/icons/ic_back.png'),
                                                      width: 25,
                                                      height: 25,
                                                      fit: BoxFit.contain,
                                                      color: ColorConstant.white,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                ),

                                const Positioned(
                                  right: 16,
                                  top: 20,
                                  child: SizedBox(
                                    width: 120,
                                    height: 100,
                                    child: Image(
                                      image: AssetImage('assets/images/delivery.png'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),

                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: SizedBox(
                                      height: 230,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: ColorConstant.white,
                                              borderRadius: BorderRadius.circular(16),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: const Offset(0, 0),
                                                    blurRadius: 3,
                                                    color: Colors.grey.shade400
                                                )
                                              ]
                                          ),
                                          child: Column(
                                            children: [
                                              Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top: 8, left: 8, right: 16),
                                                    child: Row(
                                                      children: [
                                                        Expanded(
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                  'ที่อยู่จัดส่ง',
                                                                  style: _textTheme.subtitle1?.copyWith(fontSize: 18),
                                                                ),
                                                                BlocBuilder<CheckoutBloc, CheckoutState>(
                                                                  builder: (context, state) {
                                                                    return TextField(
                                                                      controller: _controllerAddress,
                                                                      focusNode: _focusNodeAddress,
                                                                      decoration: InputDecoration(
                                                                        contentPadding: const EdgeInsets.all(4),
                                                                        enabledBorder: (_controllerAddress.text.isEmpty)? UnderlineInputBorder(
                                                                            borderSide: BorderSide(width: 1, color: Colors.grey.shade400)
                                                                        ): const UnderlineInputBorder(
                                                                            borderSide: BorderSide.none
                                                                        ),
                                                                        focusedBorder: UnderlineInputBorder(
                                                                            borderSide: BorderSide(width: 1, color: Colors.grey.shade400)
                                                                        ),
                                                                        hintText: 'เพิ่มที่อยู่จัดส่ง',
                                                                        hintStyle: _textTheme.bodyText1?.copyWith(fontSize: 12, color: Colors.grey.shade400),
                                                                      ),
                                                                      onChanged: (value) {
                                                                        context.read<CheckoutBloc>().add(EditAddressTextField(text: value));
                                                                      },
                                                                      style: _textTheme.bodyText1?.copyWith(fontSize: 12),
                                                                      maxLines: 3,
                                                                      cursorColor: ColorConstant.black,
                                                                      onSubmitted: (value) {
                                                                        nextToFocus(_focusNodeComment);
                                                                      },
                                                                    );
                                                                  }
                                                                )
                                                              ],
                                                            )
                                                        ),
                                                        Align(
                                                            alignment: Alignment.topRight,
                                                            child: (_focusNodeAddress.hasPrimaryFocus || _focusNodeComment.hasPrimaryFocus)
                                                                ? GestureDetector(
                                                                onTap: () => unFocusTextField(),
                                                                child: Container(
                                                                  width: 30,
                                                                  height: 30,
                                                                  padding: const EdgeInsets.all(8),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.green,
                                                                      borderRadius: BorderRadius.circular(4)
                                                                  ),
                                                                  child: const Icon(
                                                                    Icons.check,
                                                                    color: ColorConstant.white,
                                                                    size: 16,
                                                                  ),
                                                                )
                                                            )
                                                                : GestureDetector(
                                                              onTap: () => nextToFocus(_focusNodeAddress),
                                                              child: const Image(
                                                                image: AssetImage('assets/icons/ic_edit.png'),
                                                                width: 30,
                                                                height: 30,
                                                              ),
                                                            )
                                                        )
                                                      ],
                                                    ),
                                                  )
                                              ),

                                              SizedBox(
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
                                                    child: Text(
                                                      'รายละเอียดที่อยู่จัดส่ง',
                                                      style: _textTheme.subtitle1?.copyWith(fontSize: 16),
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              SizedBox(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                                                  child: BlocBuilder<CheckoutBloc, CheckoutState>(
                                                    builder: (context, state) {
                                                      return TextField(
                                                        controller: _controllerComment,
                                                        focusNode: _focusNodeComment,
                                                        decoration: InputDecoration(
                                                          contentPadding: const EdgeInsets.all(4),
                                                          enabledBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(width: 1, color: Colors.grey.shade400)
                                                          ),
                                                          focusedBorder: UnderlineInputBorder(
                                                              borderSide: BorderSide(width: 1, color: Colors.grey.shade400)
                                                          ),
                                                        ),
                                                        onChanged: (value) {
                                                          context.read<CheckoutBloc>().add(EditCommentTextField(text: value));
                                                        },
                                                        style: _textTheme.bodyText1?.copyWith(fontSize: 16),
                                                        maxLines: 1,
                                                        cursorColor: ColorConstant.black,
                                                      );
                                                    }
                                                  )
                                                ),
                                              )

                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                          Expanded(
                            child: ListView(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.all(0),
                              children: [
                                const SizedBox(height: 16,),
                                SizedBox(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                      color: ColorConstant.primary,
                                      child: Text(
                                        'ข้อมูลลูกค้า',
                                        style: _textTheme.subtitle1?.copyWith(fontSize: 18, color: ColorConstant.white),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8,),
                                SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 32),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'ชื่อผู้รับสินค้า',
                                          style: _textTheme.subtitle1?.copyWith(fontSize: 16),
                                        ),
                                        BlocBuilder<CheckoutBloc, CheckoutState>(
                                          builder: (context, state) {
                                            return TextField(
                                              controller: _controllerFullName,
                                              focusNode: _focusNodeFullName,
                                              decoration: InputDecoration(
                                                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                                                enabledBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(width: 1, color: Colors.grey.shade400)
                                                ),
                                                focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(width: 1, color: Colors.grey.shade400)
                                                ),
                                              ),
                                              style: _textTheme.bodyText1?.copyWith(fontSize: 16, color: ColorConstant.blue),
                                              onChanged: (value) {
                                                context.read<CheckoutBloc>().add(EditFullNameTextField(text: value));
                                              },
                                              maxLines: 1,
                                              keyboardType: TextInputType.text,
                                              cursorColor: ColorConstant.blue,
                                              onSubmitted: (value) {
                                                nextToFocus(_focusNodePhoneNumber);
                                              },
                                              textInputAction: TextInputAction.next,
                                            );
                                          }
                                        ),
                                        const SizedBox(height: 8,),
                                        Text(
                                          'เบอร์ผู้รับสินค้า',
                                          style: _textTheme.subtitle1?.copyWith(fontSize: 16),
                                        ),
                                        BlocBuilder<CheckoutBloc, CheckoutState>(
                                          builder: (context, state) {
                                            return TextField(
                                              controller: _controllerPhoneNumber,
                                              focusNode: _focusNodePhoneNumber,
                                              decoration: InputDecoration(
                                                counterText: '',
                                                contentPadding: const EdgeInsets.symmetric(horizontal: 24),
                                                enabledBorder: (_controllerPhoneNumber.text.isEmpty) ? UnderlineInputBorder(
                                                    borderSide: BorderSide(width: 1, color: Colors.grey.shade400)
                                                ) : const UnderlineInputBorder(
                                                    borderSide: BorderSide.none
                                                ),
                                                focusedBorder: UnderlineInputBorder(
                                                    borderSide: BorderSide(width: 1, color: Colors.grey.shade400)
                                                ),
                                              ),
                                              style: _textTheme.bodyText1?.copyWith(fontSize: 16, color: ColorConstant.blue),
                                              onChanged: (value) {
                                                context.read<CheckoutBloc>().add(EditPhoneNumberTextField(text: value));
                                              },
                                              maxLines: 1,
                                              maxLength: 10,
                                              keyboardType: TextInputType.phone,
                                              cursorColor: ColorConstant.blue,
                                              onSubmitted: (value) => unFocusTextField(),
                                              textInputAction: TextInputAction.done,
                                            );
                                          }
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16,),
                                SizedBox(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                      color: ColorConstant.primary,
                                      child: Text(
                                        'รายการสินค้า',
                                        style: _textTheme.subtitle1?.copyWith(fontSize: 18, color: ColorConstant.white),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 24,),
                                SizedBox(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Row(
                                      children: [
                                        const Image(
                                          image: AssetImage('assets/images/delivery.png'),
                                          width: 80,
                                          height: 48,
                                        ),
                                        const SizedBox(width: 16,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'จัดส่งโดยสาขา',
                                              style: _textTheme.bodyText1?.copyWith(fontSize: 14),
                                            ),
                                            BlocBuilder<CheckoutBloc, CheckoutState>(
                                              builder: (context, checkoutState) {
                                                return BlocBuilder<BranchBloc, BranchState>(
                                                    builder: (context, branchState) {
                                                      String text = "";
                                                      if (branchState is BranchLoaded) {
                                                        if (checkoutState is CheckoutLoaded) {
                                                          if (checkoutState.comment == null) {
                                                            context.read<CheckoutBloc>().add(SetBranch(branchId: branchState.branch.branchId));
                                                          }
                                                        }
                                                        text = branchState.branch.branchName;
                                                      }
                                                      else {
                                                        text = "กำลังค้นหา...";
                                                      }
                                                      return Text(
                                                        text,
                                                        style: _textTheme.subtitle1?.copyWith(fontSize: 18,),
                                                      );
                                                    }
                                                );
                                              }
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16,),
                                const SizedBox(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 32),
                                    child: Divider(color: ColorConstant.grey,),
                                  ),
                                ),
                                SizedBox(
                                  width: size.width,
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 16, right: 32),
                                      child: BlocBuilder<BasketBloc, BasketState>(
                                          builder: (context, state) {
                                            if (state is BasketLoaded) {
                                              return ListView.separated(
                                                shrinkWrap: true,
                                                physics: const NeverScrollableScrollPhysics(),
                                                itemCount: state.items.length,
                                                itemBuilder: (context, index) {
                                                  BasketObject basket = state.items[index];
                                                  return Padding(
                                                    padding: EdgeInsets.only(bottom: (index == (state.items.length - 1)) ? 150 : 0),
                                                    child: CheckoutItem(
                                                        imagePath: basket.product.images,
                                                        title: basket.product.productName,
                                                        price: basket.product.pricePerUnit,
                                                        count: basket.qty
                                                    ),
                                                  );
                                                },
                                                separatorBuilder: (context, index) => const SizedBox(height: 12,),
                                              );
                                            }
                                            return Container();
                                          }
                                      )
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: (_focusNodeAddress.hasPrimaryFocus || _focusNodeComment.hasPrimaryFocus || _focusNodeFullName.hasPrimaryFocus || _focusNodePhoneNumber.hasPrimaryFocus)
                          ? const SizedBox()
                          : Container(
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
                                Text(
                                  'ราคารวม',
                                  style: _textTheme.subtitle1?.copyWith(fontSize: 28),
                                ),
                                BlocBuilder<BasketBloc, BasketState>(
                                    builder: (context, state) {
                                      if (state is BasketLoaded) {
                                        return RichText(
                                          text: TextSpan(
                                              text: generateCurrencyFormat(getTotalPriceInBasket(baskets: state.items) + ValueConstant.shippingPrice),
                                              style: _textTheme.subtitle1?.copyWith(fontSize: 28, color: ColorConstant.blue),
                                              children: [
                                                TextSpan(
                                                    text: '  บาท',
                                                    style: _textTheme.subtitle1?.copyWith(fontSize: 14, color: ColorConstant.black)
                                                )
                                              ]
                                          ),
                                        );
                                      }
                                      return Container();
                                    }
                                )
                              ],
                            ),
                            BlocBuilder<BasketBloc, BasketState>(
                                builder: (context, state) {
                                  if (state is BasketLoaded) {
                                    return ElevatedButton(
                                        onPressed: (_controllerAddress.text.isEmpty || _controllerFullName.text.isEmpty || _controllerPhoneNumber.text.isEmpty)
                                            ? null : () async {
                                          if (await requestPermission(Permission.storage)) {
                                            showDialogConfirmShipping(context, state.items);
                                          } else {
                                            showErrorDialog(context: context, message: "กรุณากด อนุญาต ก่อนดำเนินรายการ");
                                          }
                                        },
                                        child: const Text(
                                            "ยืนยันการซื้อสินค้า"
                                        )
                                    );
                                  }
                                  return const SizedBox();
                                }
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
            ),
          ),
        ),
      )
    );
  }

  void unFocusTextField() => FocusManager.instance.primaryFocus?.unfocus();

  void nextToFocus(FocusNode focusNode) => FocusScope.of(context).requestFocus(focusNode);

  Future<void> showDialogConfirmShipping(BuildContext context, List<BasketObject> baskets) async {
    TextTheme _textTheme = Theme.of(context).textTheme;
    await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            'แจ้งเตือน',
            style: _textTheme.subtitle1?.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'คุณยืนยันที่จะสั่งสินค้าหรือไม่ ?',
            style: _textTheme.subtitle1?.copyWith(fontSize: 14),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'ยกเลิก',
                  style: _textTheme.subtitle1?.copyWith(fontSize: 16),
                )
            ),
            TextButton(
                onPressed: (){
                  Navigator.of(context).pop(false);
                  context.read<CheckoutBloc>().add(ClickButtonCheckout(baskets: baskets));
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

  Future<bool> showDialogAlertBackToHome(BuildContext context) async {
    TextTheme _textTheme = Theme.of(context).textTheme;
    return await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(
            'แจ้งเตือน',
            style: _textTheme.subtitle1?.copyWith(fontSize: 14),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'คุณต้องการยกเลิกคำสั่งซื้อหรือไม่ ?',
            style: _textTheme.subtitle1?.copyWith(fontSize: 14),
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'ยกเลิก',
                  style: _textTheme.subtitle1?.copyWith(fontSize: 16),
                )
            ),
            TextButton(
                onPressed: (){
                  Navigator.of(context).pop(false);
                  Navigator.of(context).pushNamedAndRemoveUntil(Routes.dashboardRoute, (route) => false);
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

  Future showLoading(BuildContext context) async {
    await showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => Dialog(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(
                  width: 80,
                  height: 80,
                  child: CircularProgressIndicator(),
                ),
                SizedBox(height: 16,),
                Text('Loading')
              ],
            ),
          ),
        )
    );
  }

  static void hideLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

  static Future showErrorDialog({
    required BuildContext context,
    required String message,
    Function()? listenerOk
  }) async {
    await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) => AlertDialog(
          title: const Text('แจ้งเตือน'),
          content: Text(
            message,
            style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
                onPressed: (listenerOk != null) ? listenerOk : (){
                  Navigator.of(context).pop();
                },
                child: const Text("ตกลง")
            )
          ],
        )
    );
  }
}
