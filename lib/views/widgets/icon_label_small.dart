import 'package:flutter/material.dart';

class IconLabelSmall extends StatelessWidget {
  const IconLabelSmall({Key? key, this.maxWidth = 30.0, required this.icon, required this.labelText})
      : super(key: key);
  final Icon icon;
  final SelectableText labelText;
  final double maxWidth;
  @override
  Widget build(BuildContext context) {
    return Container(constraints: BoxConstraints(maxWidth: maxWidth),
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 4,
          ),
          labelText,
        ],
      ),
    );
  }
}
