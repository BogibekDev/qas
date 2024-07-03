import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qas/presentation/widget/shimmer.dart';

import '../../domain/entities/profile/returned.dart';
import '../../tools/res_color.dart';
import '../../tools/utils.dart';

class ReturnedCarItem extends StatefulWidget {
  final Returned car;
  final Function() onItemClick;

  const ReturnedCarItem(
      {required this.car, required this.onItemClick, super.key});

  @override
  State<ReturnedCarItem> createState() => _ReturnedCarItemState();
}

class _ReturnedCarItemState extends State<ReturnedCarItem> {
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
                child: CachedNetworkImage(
                  width: MediaQuery.sizeOf(context).width / 4,
                  height: MediaQuery.sizeOf(context).width / 4 - 10,
                  imageUrl: "${widget.car.images?[0]}",
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: Shimmer(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error_outline,
                    size: 100,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Text(
                            "Статус :",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          Expanded(
                            child: Text(
                              "${widget.car.status}".tr(),
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
                              "Қайтарилган сана : ",
                              overflow: TextOverflow.fade,
                              maxLines: 3,
                            ),
                          ),
                          Text(
                            "${widget.car.returnedDate}",
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
