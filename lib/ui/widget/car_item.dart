import 'package:flutter/material.dart';

import '../../data/model/car_model.dart';
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
                child: Image(
                  width: MediaQuery.sizeOf(context).width / 4,
                  height: MediaQuery.sizeOf(context).width / 4 - 10,
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.car.image_url),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.car.name,
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
                            "Ishlab chiqarilgan yili:",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                          Expanded(
                            child: Text(
                              widget.car.year,
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
                            child: const Text(
                              "Bosib o'tilgan yo'l: ",
                              overflow: TextOverflow.fade,
                              maxLines: 3,
                            ),
                          ),
                          Text(
                            "${widget.car.mileage} KM",
                            style:
                                const TextStyle(fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Narx: "),
                          Text(
                            widget.car.price.priceWithMLN(),
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
