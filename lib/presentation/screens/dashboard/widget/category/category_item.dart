import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {

  final Function()? onClick;
  final String imagePath;
  final String title;

  const CategoryItem({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    TextTheme _textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onClick,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(imagePath)
                )
            ),
          ),
          Text(
            title,
            style: _textTheme.bodyText1?.copyWith(fontSize: 12),
          )
        ],
      ),
    );
  }
}
