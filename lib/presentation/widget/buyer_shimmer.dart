import 'package:flutter/material.dart';

import 'shimmer.dart';

class BuyerShimmer extends StatefulWidget {
  const BuyerShimmer({super.key});

  @override
  State<BuyerShimmer> createState() => _BuyerShimmerState();
}

class _BuyerShimmerState extends State<BuyerShimmer> {
  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Shimmer(height: 30),
        SizedBox(height: 10),
        Shimmer(height: 30),
        SizedBox(height: 10),
        Shimmer(height: 30),
      ],
    );
  }
}
