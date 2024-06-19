import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/home/car.dart';
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
                    imageUrl: widget.car.images![0],
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
                        "${widget.car.model}  ${widget.car.year}",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: widget.car.model!.length > 15
                              ? 12
                              : widget.car.model!.length > 10
                                  ? 18
                                  : 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                        maxLines: 2,
                      ),
                      Text(
                        widget.car.price!.priceWithMLN(),
                        style: TextStyle(
                          fontSize: widget.car.model!.length > 15
                              ? 10
                              : widget.car.model!.length > 10
                                  ? 16
                                  : 18,
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
