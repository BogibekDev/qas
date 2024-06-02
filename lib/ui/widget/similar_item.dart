import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qas/data/model/car_model.dart';

import '../../tools/res_color.dart';
import '../../tools/utils.dart';

class SimilarItem extends StatefulWidget {
  final Car car;
  final Function() onItemClick;

  const SimilarItem({super.key, required this.car, required this.onItemClick});

  @override
  State<SimilarItem> createState() => _SimilarItemState();
}

class _SimilarItemState extends State<SimilarItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onItemClick.call();
      },
      child: SizedBox(
        height: 180,
        width: 170,
        child: Card(
          surfaceTintColor: ResColors.white,
          color: ResColors.white,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.car.image_url,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error_outline,
                      size: 50,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        "${widget.car.name}  ${widget.car.year}",
                        style: const TextStyle(
                          color: ResColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                        maxLines: 2,
                      ),
                      Text(
                        widget.car.price.priceWithMLN(),
                        style: const TextStyle(
                          color: ResColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
