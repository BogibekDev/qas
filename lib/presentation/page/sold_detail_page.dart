import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../config/injection.dart';
import '../../tools/res_color.dart';
import '../../tools/utils.dart';
import '../viewmodel/sold_detail_viewmodel.dart';
import '../widget/detail_shimmer.dart';
import '../widget/shimmer.dart';

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
                        width: MediaQuery.sizeOf(context).width,
                        imageUrl: viewModel.soldCar.images![0],
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) => const Icon(
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
                            const Text(
                              "Сотув ҳақида: ",
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
                                  "Сотилган сана: ",
                                  style: TextStyle(
                                    color: ResColors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${viewModel.soldCar.soldDate}",
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
                                const Text(
                                  "Тўлов тури: ",
                                  style: TextStyle(
                                    color: ResColors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${viewModel.soldCar.paymentType}".tr(),
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
                                const Text(
                                  "Олиб қолинган нархи: ",
                                  style: TextStyle(
                                    color: ResColors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${viewModel.soldCar.car?.camePrice}".price(),
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
                                const Text(
                                  "Sotilgan narx: ",
                                  style: TextStyle(
                                    color: ResColors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${viewModel.soldCar.car?.price}".price(),
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
                                const Text(
                                  "Фойда: ",
                                  style: TextStyle(
                                    color: ResColors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${viewModel.soldCar.profit}".price(),
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
                                const Text(
                                  "Компенсация пули: ",
                                  style: TextStyle(
                                    color: ResColors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${viewModel.soldCar.compensationPrice}"
                                      .price(),
                                  style: const TextStyle(
                                    color: ResColors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 8),
                            viewModel.soldCar.description != null
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        "Қўшимча изоҳ: ",
                                        style: TextStyle(
                                          color: ResColors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text(
                                        "${viewModel.soldCar.description}",
                                        style: const TextStyle(
                                          color: ResColors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      )
                                    ],
                                  )
                                : Container(),
                            const SizedBox(height: 16),
                            const Text(
                              "Автомобиль ҳақида: ",
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
                                  "${"${viewModel.soldCar.car?.kilometer}".addSpace()} KM",
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
                            const Text(
                              "Автомобил эгасининг малумотлари:",
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
                                  "Ф.И.Ш: ",
                                  style: TextStyle(
                                    color: ResColors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${viewModel.soldCar.buyer?.firstName} ${viewModel.soldCar.buyer?.lastName} ${viewModel.soldCar.buyer?.middleName}",
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
                                  "Туғилган сана: ",
                                  style: const TextStyle(
                                    color: ResColors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${viewModel.soldCar.buyer?.birthYear}",
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
                                  "Pasport рақами: ",
                                  style: const TextStyle(
                                    color: ResColors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${viewModel.soldCar.buyer?.passport}",
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
                                  "Телефон: ",
                                  style: const TextStyle(
                                    color: ResColors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${viewModel.soldCar.buyer?.phoneNumber}",
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
                                  "Қўшимча телефон: ",
                                  style: const TextStyle(
                                    color: ResColors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${viewModel.soldCar.buyer?.extraPhoneNumber}",
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
                                  "Манзили: ",
                                  style: const TextStyle(
                                    color: ResColors.black,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "${viewModel.soldCar.buyer?.address}",
                                  style: const TextStyle(
                                      color: ResColors.black,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              "Изоҳ",
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
                            var pdfUrl = viewModel.soldCar.contract ?? "";
                            openPDF(pdfUrl);
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
                      width: MediaQuery.sizeOf(context).width / 2,
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

  Future<bool> openPDF(String url) async {
    return await launchUrlString(url);
  }
}
