import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:salaya_delivery_app/core/constants/color_constant.dart';
import 'package:salaya_delivery_app/presentation/router/route_manager.dart';
import 'package:salaya_delivery_app/presentation/screens/search/widget/search_item/search_item.dart';
import 'package:salaya_delivery_app/presentation/utils/custom_appbar.dart';

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

    return GestureDetector(
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
              'ค้นหายา',
              style: _textTheme.subtitle1?.copyWith(color: ColorConstant.white, fontSize: 20),
            )
        ),
        body: Column(
          children: [
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                child: TextField(
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
                  cursorColor: ColorConstant.black,
                  style: _textTheme.bodyText1?.copyWith(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 16,),
            Expanded(
                child: ListView.separated(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SearchItem(
                        onClickItem: () => Navigator.of(context).pushNamed(Routes.productDetailsRoute, arguments: '1234'),
                        imagePath: 'assets/images/y1.png',
                        title: 'ยาเม็ดซาร่า (10 เม็ด)',
                        price: '12.00'
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 16,),
                )
            )

          ],
        ),
      ),
    );
  }

  void unFocusTextField() => FocusManager.instance.primaryFocus?.unfocus();
}
