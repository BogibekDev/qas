import 'package:flutter/material.dart';
import 'package:qas/presentation/widget/shimmer.dart';
import 'package:qas/tools/res_color.dart';

class DetailShimmer extends StatelessWidget {
  const DetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Shimmer(height: 200),
          Container(
            margin: const EdgeInsets.only(top: 6, left: 10, right: 10),
            height: 4,
            width: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 4,
              itemBuilder: (context, position) =>
                  GestureDetector(onTap: () {}, child: const Shimmer()),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Shimmer(height: 20, width: 100),
                const SizedBox(height: 10),
                Container(
                  width: MediaQuery.sizeOf(context).width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  decoration: BoxDecoration(
                      color: ResColors.textFieldBg,
                      borderRadius: BorderRadius.circular(10.0)),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer(height: 20, width: 100),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer(height: 20, width: 100),
                                SizedBox(height: 8),
                                Shimmer(height: 20, width: 100)
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer(height: 20, width: 100),
                                SizedBox(height: 8),
                                Shimmer(height: 20, width: 100)
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Shimmer(height: 20, width: 100),
                    SizedBox(width: 30),
                    Shimmer(height: 20, width: 100)
                  ],
                ),
                const SizedBox(height: 16),
                const Shimmer(height: 20, width: 100),
                const SizedBox(height: 16),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer(height: 20, width: 100),
                    Shimmer(height: 20, width: 100),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer(height: 20, width: 100),
                    Shimmer(height: 20, width: 100),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer(height: 20, width: 100),
                    Shimmer(height: 20, width: 100),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer(height: 20, width: 100),
                    Shimmer(height: 20, width: 100),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer(height: 20, width: 100),
                    Shimmer(height: 20, width: 100),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer(height: 20, width: 100),
                    Shimmer(height: 20, width: 100),
                  ],
                ),
                const SizedBox(height: 8),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Shimmer(height: 20, width: 100),
                    Shimmer(height: 20, width: 100),
                  ],
                ),
                const SizedBox(height: 16),
                const Shimmer(height: 20, width: 100),
                const SizedBox(height: 10),
                const Shimmer(height: 20, width: 100),
                const SizedBox(height: 16),
                const Shimmer(height: 20, width: 100),
                const SizedBox(height: 10),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
