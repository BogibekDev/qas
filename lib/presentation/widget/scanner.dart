import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner extends StatelessWidget {
  const Scanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 400,
        child: MobileScanner(
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            for (final barcode in barcodes) {
              Navigator.canPop(context)
                  ? Navigator.pop<String>(
                      context, barcode.rawValue ?? 'No data in QR')
                  : null;
            }
          },
        ),
      ),
    );
  }
}
