import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qas/tools/res_color.dart';

class Scanner extends StatelessWidget {
  const Scanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ResColors.mainBg,
        title: Text("QR code'ni scannerlang"),
        centerTitle: true,
      ),
      backgroundColor: ResColors.mainBg,
      body: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width - 100,
          height: MediaQuery.sizeOf(context).width - 100,
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
      ),
    );
  }
}
