import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/injection.dart';
import '../../tools/res_color.dart';
import '../../tools/utils.dart';
import '../viewmodel/detail_viewmodel.dart';
import '../widget/detail_shimmer.dart';
import '../widget/shimmer.dart';
import '../widget/similar_item.dart';
import 'sell_page.dart';

final detailNotifierProvider =
    ChangeNotifierProvider.autoDispose<DetailViewModel>((ref) {
  return DetailViewModel(ref.read(detailUseCase), ref.read(carReturn));
});

class DetailPage extends ConsumerWidget {
  const DetailPage({required this.carId, super.key});

  final int carId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final DetailViewModel detailViewModel = ref.watch(detailNotifierProvider)
      ..id = carId;

    return Scaffold(
      backgroundColor: ResColors.mainBg,
      appBar: AppBar(
        backgroundColor: ResColors.mainBg,
        title: detailViewModel.isLoading
            ? const Shimmer(width: 100)
            : Text(
                detailViewModel.car.model ?? "",
                style: const TextStyle(fontSize: 32, color: ResColors.black),
              ),
        centerTitle: true,
      ),
      body: detailViewModel.isLoading
          ? const DetailShimmer()
          : SingleChildScrollView(
              child: Column(
                children: [
                  CarouselSlider(
                    carouselController: detailViewModel.carouselController,
                    items: detailViewModel.car.images?.map((image) {
                      return CachedNetworkImage(
                        width: MediaQuery.sizeOf(context).width,
                        imageUrl: image,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.error_outline,
                          size: 100,
                        ),
                        fit: BoxFit.cover,
                      );
                    }).toList(),
                    options: CarouselOptions(
                      viewportFraction: 1.0,
                      enlargeCenterPage: true,
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
                          detailViewModel.carouselController
                              .animateToPage(position);
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
                              Text("termPayment".tr(),
                                  style: const TextStyle(
                                    color: ResColors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  )),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "advancePayment".tr(),
                                          style: const TextStyle(
                                            color: ResColors.black,
                                          ),
                                        ),
                                        Text(
                                          (detailViewModel.car.prePrice ??
                                                  "0.0")
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "monthlyPayment".tr(),
                                          style: const TextStyle(
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
                            Text(
                              "${"branch".tr()} :",
                              style: const TextStyle(
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
                        Text(
                          "info".tr(),
                          style: const TextStyle(
                              color: ResColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${"madeYear".tr()}: ",
                              style: const TextStyle(
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
                            Text(
                              "${"model".tr()}: ",
                              style: const TextStyle(
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
                            Text(
                              "${"color".tr()}: ",
                              style: const TextStyle(
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
                            Text(
                              "${"fuelType".tr()}: ",
                              style: const TextStyle(
                                color: ResColors.black,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${detailViewModel.car.fuelType?.tr()}",
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
                            Text(
                              "${"type".tr()}: ",
                              style: const TextStyle(
                                color: ResColors.black,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${detailViewModel.car.type?.tr()}",
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
                            Text(
                              "${"kilometre".tr()}: ",
                              style: const TextStyle(
                                color: ResColors.black,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${detailViewModel.car.kilometer}",
                              style: const TextStyle(
                                color: ResColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${"paint".tr()}: ",
                              style: const TextStyle(
                                color: ResColors.black,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              "${detailViewModel.car.isPainted?.tr()}",
                              style: const TextStyle(
                                color: ResColors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "moreInfo".tr(),
                          style: const TextStyle(
                            color: ResColors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
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
                        (detailViewModel.car.similar ?? []).isNotEmpty
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "similarCars".tr(),
                                    style: const TextStyle(
                                      color: ResColors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: 200,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          detailViewModel.car.similar?.length,
                                      itemBuilder: (context, position) =>
                                          SimilarItem(
                                        car: detailViewModel
                                            .car.similar![position],
                                        onItemClick: () {
                                          detailViewModel.loadCarDetail(
                                              detailViewModel.car
                                                      .similar![position].id ??
                                                  detailViewModel.car.id ??
                                                  1);
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - 24,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ResColors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SellPage(carId: carId),
                          ),
                        );
                      },
                      child: Text(
                        "sell".tr(),
                        style: const TextStyle(
                          color: ResColors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width - 24,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ResColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        _backSheet(context, detailViewModel, carId);
                      },
                      child: Text(
                        "back".tr(),
                        style: const TextStyle(
                          color: ResColors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
    );
  }

  Future _backSheet(
      BuildContext context, DetailViewModel detailViewModel, carId) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      barrierColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: SizedBox(
            width: MediaQuery.sizeOf(context).width,
            height: 440,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "back".tr(),
                  style: const TextStyle(
                    color: ResColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  "cause".tr(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: ResColors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: const BoxDecoration(
                      color: ResColors.textFieldBg,
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  child: TextField(
                    controller: detailViewModel.reasonController,
                    maxLines: 9,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      hintText: "cause".tr(),
                      hintStyle: const TextStyle(
                        color: ResColors.black,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ResColors.textFieldBg,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "cancel".tr(),
                            style: const TextStyle(
                              color: ResColors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        height: 60,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ResColors.mainColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            detailViewModel.returnCar();
                          },
                          child: detailViewModel.isReturnLoading
                              ? const CircularProgressIndicator()
                              : Text(
                                  "back".tr(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: ResColors.white,
                                    fontSize: 18,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
