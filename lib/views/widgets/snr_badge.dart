import 'package:flutter/material.dart';

class SnrBadge extends StatelessWidget {
const SnrBadge({ Key? key, required this.snr }) : super(key: key);
final int snr;
  @override
  Widget build(BuildContext context){
    return Container(
      width: 45,
      height: 30,
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.elliptical(3, 3),
          )),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.signal_cellular_alt, color: Colors.blue),
             
            const Text(textAlign: TextAlign.center,
              'snr',
              style: TextStyle(
                  fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w600),
            ),
            Text(
              '$snr db',
              style: const TextStyle(
                  fontSize: 12, color: Colors.blue, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}