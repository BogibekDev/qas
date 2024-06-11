import 'package:flutter/material.dart';
import 'package:qas/presentation/widget/shimmer.dart';

import '../../tools/res_color.dart';

class CarItemShimmer extends StatefulWidget {
  const CarItemShimmer({super.key});

  @override
  State<CarItemShimmer> createState() => _CarItemState();
}

class _CarItemState extends State<CarItemShimmer> {
  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: ResColors.white,
      color: ResColors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Shimmer(
                width: MediaQuery.sizeOf(context).width / 4,
                height: MediaQuery.sizeOf(context).width / 4 - 10,
              ),
            ),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer(height: 10),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Shimmer(height: 10, width: 100),
                        SizedBox(width: 20),
                        Expanded(child: Shimmer(height: 10))
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Shimmer(height: 10)),
                        SizedBox(width: 20),
                        Shimmer(
                          height: 10,
                          width: 100,
                        ),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Shimmer(height: 10, width: 50),
                        Shimmer(height: 10, width: 100)
                      ],
                    ),
                    SizedBox(height: 12)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
