import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qas/config/injection.dart';

import '../../fake/fakes.dart';
import '../../tools/res_color.dart';
import '../../tools/utils.dart';
import '../viewmodel/detail_viewmodel.dart';
import '../widget/similar_item.dart';

final detailNotifierProvider =
    ChangeNotifierProvider.autoDispose<DetailViewModel>((ref) {
  return DetailViewModel(ref.read(detailUseCase));
});

class DetailPage extends ConsumerWidget {
    DetailPage({required this.carId, super.key}){
      
    }

  final int carId;


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final  DetailViewModel detailViewModel = ref.watch(detailNotifierProvider)
    ..id = carId;

    return Scaffold(
      backgroundColor: ResColors.mainBg,
      appBar: AppBar(
        backgroundColor: ResColors.mainBg,
        title: Text(
          car.name,
          style: const TextStyle(color: ResColors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
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
                  detailViewModel.caruselIndex = index;
                },
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 6, left: 10, right: 10),
              height: 4,
              width: (detailViewModel.car.images?.length??1.0) * 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: detailViewModel.car.images?.length,
                itemBuilder: (context, position) => GestureDetector(
                  onTap: () {
                    detailViewModel.caruselIndex = position;
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
                                    (detailViewModel.car.prePrice ?? "")
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
                                    "${detailViewModel.car.period} x ~ ${(detailViewModel.car.pricePerMonth ?? "").price()}",
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
        ),
      ),
      floatingActionButton: SizedBox(
        width: MediaQuery.sizeOf(context).width - 24,
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ResColors.mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {},
          child: const Text(
            "Sotish",
            style: TextStyle(
              color: ResColors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
