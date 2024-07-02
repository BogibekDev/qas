import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/injection.dart';
import '../../tools/res_color.dart';
import '../viewmodel/sold_detail_viewmodel.dart';
import '../widget/detail_shimmer.dart';
import '../widget/shimmer.dart';
import '../../tools/utils.dart';


final detailNotifierProvider =
ChangeNotifierProvider.family.autoDispose((ref, int carId) {
  return SoldDetailViewModel(ref.read(getSoldCar), carId);
});

class SoldDetailPage extends ConsumerWidget {
  const SoldDetailPage({required this.carId, super.key});

  final int carId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final SoldDetailViewModel viewModel =
    ref.watch(detailNotifierProvider(carId));
    return Scaffold(
        backgroundColor: ResColors.mainBg,
        appBar: AppBar(
          backgroundColor: ResColors.mainBg,
          title: viewModel.isLoading
              ? const Shimmer(width: 100)
              : Text(
            viewModel.soldCar.car?.model ?? "",
            style: const TextStyle(fontSize: 32, color: ResColors.black),
          ),
          centerTitle: true,
        ),
        body: viewModel.isLoading
            ? const DetailShimmer()
            : viewModel.soldCar.id != null
            ? SingleChildScrollView(
          child: Column(
            children: [
              CachedNetworkImage(
                width: MediaQuery
                    .sizeOf(context)
                    .width,
                imageUrl: viewModel.soldCar.images![0],
                placeholder: (context, url) =>
                const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) =>
                const Icon(
                  Icons.error_outline,
                  size: 100,
                ),
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      (viewModel.soldCar.price ?? "0").price(),
                      style: const TextStyle(
                        fontSize: 32,
                        color: ResColors.black,
                        fontWeight: FontWeight.w900,
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
                          "${viewModel.soldCar.car?.branch?.title}",
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
                          "${viewModel.soldCar.car?.year}",
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
                          "${viewModel.soldCar.car?.model}",
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
                          "${viewModel.soldCar.car?.color}",
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
                          "${viewModel.soldCar.car?.fuelType?.tr()}",
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
                          "${viewModel.soldCar.car?.type?.tr()}",
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
                          "${viewModel.soldCar.car?.kilometer}",
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
                          "${viewModel.soldCar.car?.isPainted?.tr()}",
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
                      "${viewModel.soldCar.car?.description}",
                      style: const TextStyle(
                        color: ResColors.black,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: MediaQuery
                    .sizeOf(context)
                    .width - 24,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ResColors.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () async {

                  },
                  child: const Text(
                    "Шартномани юклаб олиш",
                    style: const TextStyle(
                      color: ResColors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.emoji_emotions_outlined,
              size: 100,
              color: ResColors.mainColor,
            ),
            const SizedBox(height: 30),
            const Text(
              "Нимадир хато кетди ёки Машина топилмади. Илтимос янгилаш тугмасини босинг",
              style: TextStyle(
                color: ResColors.black,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: MediaQuery
                  .sizeOf(context)
                  .width / 2,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ResColors.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  viewModel.loadSoldCarDetail(carId);
                },
                child: const Text(
                  "Янгилаш",
                  style: TextStyle(
                    color: ResColors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
    );
  }
}
