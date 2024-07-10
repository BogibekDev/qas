import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qas/tools/utils.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../config/injection.dart';
import '../../tools/res_color.dart';
import '../viewmodel/returned_detail_viewmodel.dart';
import '../widget/detail_shimmer.dart';
import '../widget/shimmer.dart';

final detNotifierProvider =
    ChangeNotifierProvider.family.autoDispose((ref, int carId) {
  return ReturnedDetailViewModel(ref.read(getReturnedCar), carId);
});

class ReturnedCarDetailPage extends ConsumerWidget {
  const ReturnedCarDetailPage({required this.carId, super.key});

  final int carId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ReturnedDetailViewModel viewModel =
        ref.watch(detNotifierProvider(carId));
    return Scaffold(
      backgroundColor: ResColors.mainBg,
      appBar: AppBar(
        backgroundColor: ResColors.mainBg,
        title: viewModel.isLoading
            ? const Shimmer(width: 100)
            : Text(
          viewModel.returned.model ?? "",
          style: const TextStyle(fontSize: 32, color: ResColors.black),
        ),
        centerTitle: true,
      ),
      body: viewModel.isLoading
          ? const DetailShimmer()
          : viewModel.returned.id != null
          ? SingleChildScrollView(
        child: Column(
          children: [
            CachedNetworkImage(
              width: MediaQuery.sizeOf(context).width,
              imageUrl: viewModel.returned.images![0],
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
                    (viewModel.returned.price ?? "0").price(),
                    style: const TextStyle(
                      fontSize: 32,
                      color: ResColors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "Қайтарилиш ҳақида: ",
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
                        "Қайтарилган сана: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${viewModel.returned.returnedDate}",
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
                        "Ҳолати: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${viewModel.returned.status}".tr(),
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
                        "Қайтарилиш сабаби: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${viewModel.returned.reason}",
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
                        "Тасдиқловчи: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "${viewModel.returned.acceptor?.firstName} ${viewModel.returned.acceptor?.lastName}",
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
                    "Автомобиль ҳақида: ",
                    style: TextStyle(
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
                        "${viewModel.returned.car?.year}",
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
                        "${viewModel.returned.car?.model}",
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
                        "${viewModel.returned.car?.color}",
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
                        "${"${viewModel.returned.car?.kilometer}".addSpace()} KM",
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
                        "${viewModel.returned.owner?.firstName} ${viewModel.returned.owner?.lastName} \n${viewModel.returned.owner?.middleName}",
                        style: const TextStyle(
                            color: ResColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                        textAlign: TextAlign.end,
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
                        "${viewModel.returned.owner?.phoneNumber}",
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
                        viewModel.returned.owner?.extraPhoneNumber??"",
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
                        "${viewModel.returned.owner?.address}",
                        style: const TextStyle(
                            color: ResColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
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
                  var pdfUrl = viewModel.returned.pdfLink ?? "";
                  openPDF(pdfUrl);
                },
                child: const Text(
                  "Далолатномани юклаб олиш",
                  style: TextStyle(
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
                viewModel.getDetail(carId);
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
