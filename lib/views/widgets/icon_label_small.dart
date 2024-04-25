import 'package:flutter/material.dart';

class IconLabelSmall extends StatelessWidget {
  const IconLabelSmall({Key? key, required this.icon, required this.labelText})
      : super(key: key);
  final Icon icon;
  final Text labelText;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        const SizedBox(
          width: 4,
        ),
        labelText,
      ],
    );
  }
}
