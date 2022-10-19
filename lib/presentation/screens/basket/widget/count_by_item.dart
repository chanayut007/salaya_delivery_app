import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// class CountByItemWidget extends StatefulWidget {
//
//   final Function() onClickIncrease;
//   final Function() onClickDecrease;
//   final int count;
//
//   const CountByItemWidget({Key? key, required this.onClickIncrease, required this.onClickDecrease, required this.count}) : super(key: key);
//
//   @override
//   State<CountByItemWidget> createState() => CountByItemWidgetState(count: this.count);
// }
//
// class CountByItemWidgetState extends State<CountByItemWidget> {
//
//   final int count;
//
//   CountByItemWidgetState({this.count = 1});
//
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     TextTheme _textTheme = Theme.of(context).textTheme;
//
//     return SizedBox(
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           GestureDetector(
//               onTap: (count > 1) ? () {
//                 widget.onClickDecrease();
//               } : null,
//               child: Opacity(
//                 opacity: (count > 1) ? 1 : 0.4,
//                 child: Container(
//                   width: 20,
//                   height: 20,
//                   decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       image: const DecorationImage(
//                         image: AssetImage('assets/icons/ic_minus.png'),
//                       ),
//                       boxShadow: [
//                         BoxShadow(
//                             offset: const Offset(0, 0),
//                             blurRadius: 3,
//                             color: Colors.grey.shade400
//                         )
//                       ]
//                   ),
//                 ),
//               )
//           ),
//           const SizedBox(width: 16,),
//           SizedBox(
//             width: 20,
//             height: 30,
//             child: FittedBox(
//               child: Text(
//                 '$count',
//                 style: _textTheme.subtitle1?.copyWith(fontSize: 32),
//               ),
//             ),
//           ),
//           const SizedBox(width: 16,),
//           GestureDetector(
//             onTap: () {
//               widget.onClickIncrease();
//             },
//             child: Container(
//               width: 20,
//               height: 20,
//               decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   image: const DecorationImage(
//                     image: AssetImage('assets/icons/ic_plus.png'),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                         offset: const Offset(0, 0),
//                         blurRadius: 3,
//                         color: Colors.grey.shade400
//                     )
//                   ]
//               ),
//             ),
//           ),
//
//         ],
//       ),
//     );
//   }
// }

class CountItemInBasketWidget extends StatelessWidget {

  final Function() onClickIncrease;
  final Function() onClickDecrease;
  final int count;

  const CountItemInBasketWidget({Key? key, required this.onClickIncrease, required this.onClickDecrease, this.count = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextTheme _textTheme = Theme.of(context).textTheme;

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: (count > 1) ? () {
                onClickDecrease();
              } : null,
              child: Opacity(
                opacity: (count > 1) ? 1 : 0.4,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                        image: AssetImage('assets/icons/ic_minus.png'),
                      ),
                      boxShadow: [
                        BoxShadow(
                            offset: const Offset(0, 0),
                            blurRadius: 3,
                            color: Colors.grey.shade400
                        )
                      ]
                  ),
                ),
              )
          ),
          const SizedBox(width: 16,),
          SizedBox(
            width: 20,
            height: 30,
            child: FittedBox(
              child: Text(
                '$count',
                style: _textTheme.subtitle1?.copyWith(fontSize: 32),
              ),
            ),
          ),
          const SizedBox(width: 16,),
          GestureDetector(
            onTap: () {
              onClickIncrease();
            },
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: const DecorationImage(
                    image: AssetImage('assets/icons/ic_plus.png'),
                  ),
                  boxShadow: [
                    BoxShadow(
                        offset: const Offset(0, 0),
                        blurRadius: 3,
                        color: Colors.grey.shade400
                    )
                  ]
              ),
            ),
          ),

        ],
      ),
    );
  }
}

