import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:qas/presentation/widget/shimmer.dart';

import '../../domain/entities/home/car.dart';
import '../../tools/res_color.dart';
import '../../tools/utils.dart';

class CarItem extends StatefulWidget {
  final Car car;
  final Function() onItemClick;

  const CarItem({required this.car, required this.onItemClick, super.key});

  @override
  State<CarItem> createState() => _CarItemState();
}

class _CarItemState extends State<CarItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onItemClick.call();
      },
      child: Card(
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
                child: kIsWeb
                    ? Image.network(
                        widget.car.images!.isNotEmpty
                            ? "${widget.car.images?[0]}"
                            : "",
                        width: MediaQuery.sizeOf(context).width / 4,
                        height: MediaQuery.sizeOf(context).width / 4 - 5,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, er, error) => const Center(
                          child: Icon(
                            Icons.error_outline,
                            size: 100,
                          ),
                        ),
                      )
                    : CachedNetworkImage(
                        width: MediaQuery.sizeOf(context).width / 4,
                        height: MediaQuery.sizeOf(context).width / 4 - 5,
                        imageUrl: widget.car.images!.isNotEmpty
                            ? "${widget.car.images?[0]}"
                            : "",
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child:CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Center(
                          child: Icon(
                            Icons.error_outline,
                            size: 100,
                          ),
                        ),
                      ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${widget.car.model}",
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                          ),
                          Expanded(
                            child: Text(
                              widget.car.isNew!=false ? "Янги" : "",
                              style:
                                  const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                  ),
                              textAlign: TextAlign.end,

                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Text(
                            "Йили:",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          Expanded(
                            child: Text(
                              "${widget.car.year ?? ""}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.end,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Text(
                              "Пробег: ",
                              overflow: TextOverflow.fade,
                              maxLines: 3,
                            ),
                          ),
                          Text(
                            "${widget.car.kilometer} KM",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Нарх: "),
                          Text(
                            "${widget.car.price?.priceWithMLN()}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(height: 12)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
