import 'package:flutter/material.dart';

class CwSpeedBadge extends StatelessWidget {
  const CwSpeedBadge({Key? key, required this.wpm}) : super(key: key);
  final String wpm;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45,
      height: 45,
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.elliptical(3, 3),
          )),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.speed, color: Colors.blue),
            Text(textAlign: TextAlign.center,
              wpm,
              style: const TextStyle(
                  fontSize: 12,
                  color: Colors.blue,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
