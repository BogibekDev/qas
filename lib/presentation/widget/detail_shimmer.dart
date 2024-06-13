import 'package:flutter/material.dart';

class DetailShimmer extends StatelessWidget {
  const DetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          carouselController: detailViewModel.carouselController,
          items: detailViewModel.car.images?.map((image) {
            return CachedNetworkImage(
              imageUrl: image,
              placeholder: (context, url) => const Center(
                child: CircularProgressIndicator(),
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.error_outline,
                size: 100,
              ),
            );
          }).toList(),
          options: CarouselOptions(
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              detailViewModel.carouselIndex = index;
            },
            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 6, left: 10, right: 10),
          height: 4,
          width: (detailViewModel.car.images?.length ?? 1.0) * 60,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: detailViewModel.car.images?.length,
            itemBuilder: (context, position) => GestureDetector(
              onTap: () {
                detailViewModel.carouselIndex = position;
                detailViewModel.carouselController.animateToPage(position);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6),
                width: 45,
                height: 4,
                color: detailViewModel.itemColor(position),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                (detailViewModel.car.price ?? "0").price(),
                style: const TextStyle(
                  fontSize: 32,
                  color: ResColors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.sizeOf(context).width,
                padding: const EdgeInsets.symmetric(
                    horizontal: 12, vertical: 12),
                decoration: BoxDecoration(
                    color: ResColors.textFieldBg,
                    borderRadius: BorderRadius.circular(10.0)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Muddatli to'lov",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        )),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Oldindan to'lov",
                                style: TextStyle(
                                  color: ResColors.black,
                                ),
                              ),
                              Text(
                                (detailViewModel.car.prePrice ?? "0.0")
                                    .price(),
                                style: const TextStyle(
                                  color: ResColors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Oyma-oy to'lov",
                                style: TextStyle(
                                  color: ResColors.black,
                                ),
                              ),
                              Text(
                                "${detailViewModel.car.period} x ~ ${(detailViewModel.car.pricePerMonth ?? "0.0").price()}",
                                style: const TextStyle(
                                  color: ResColors.black,
                                  fontWeight: FontWeight.w800,
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Text(
                    "Filial: ",
                    style: TextStyle(
                      color: ResColors.black,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(width: 30),
                  Text(
                    "${detailViewModel.car.branch?.title}",
                    style: const TextStyle(
                        color: ResColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Xarakteristika",
                style: TextStyle(
                    color: ResColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Ishlab chiqarilgan yili: ",
                    style: TextStyle(
                      color: ResColors.black,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "${detailViewModel.car.year}",
                    style: const TextStyle(
                        color: ResColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Model: ",
                    style: TextStyle(
                      color: ResColors.black,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "${detailViewModel.car.model}",
                    style: const TextStyle(
                        color: ResColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Rangi: ",
                    style: TextStyle(
                      color: ResColors.black,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "${detailViewModel.car.color}",
                    style: const TextStyle(
                        color: ResColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Yoqilg'i turi: ",
                    style: TextStyle(
                      color: ResColors.black,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "${fuelType[detailViewModel.car.fuelType]}",
                    style: const TextStyle(
                        color: ResColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Uzatma qutisi: ",
                    style: TextStyle(
                      color: ResColors.black,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "${type[detailViewModel.car.type]}",
                    style: const TextStyle(
                        color: ResColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Bosib o'tgan masofasi: ",
                    style: TextStyle(
                      color: ResColors.black,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "${detailViewModel.car.kilometer}",
                    style: const TextStyle(
                        color: ResColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Kraskasi: ",
                    style: TextStyle(
                      color: ResColors.black,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    "${paint[detailViewModel.car.isPainted]}",
                    style: const TextStyle(
                        color: ResColors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w700),
                  )
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Avtomobil haqida",
                style: TextStyle(
                    color: ResColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              Text(
                "${detailViewModel.car.description}",
                style: const TextStyle(
                  color: ResColors.black,
                  fontSize: 18,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 16),
              const Text(
                "O’xshash avtomobillar",
                style: TextStyle(
                    color: ResColors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: detailViewModel.car.similar?.length,
                  itemBuilder: (context, position) => SimilarItem(
                    car: detailViewModel.car.similar![position],
                    onItemClick: () {},
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
