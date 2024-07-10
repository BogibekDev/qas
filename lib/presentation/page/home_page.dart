import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/injection.dart';
import '../../tools/assets.dart';
import '../../tools/res_color.dart';
import '../viewmodel/home_viewmodel.dart';
import '../widget/car_item.dart';
import '../widget/car_item_shimmer.dart';
import '../widget/scanner.dart';
import 'detail_page.dart';
import 'profile_page.dart';

final homeNotifierProvider =
    ChangeNotifierProvider.autoDispose<HomeViewModel>((ref) {
  return HomeViewModel(ref.read(getCars), ref.read(getModels));
});

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    HomeViewModel homeViewModel = ref.watch(homeNotifierProvider);
    return Scaffold(
      backgroundColor: ResColors.mainBg,
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: ResColors.mainColor,
          leading: Image.asset(Assets.logo),
          leadingWidth: 90,
          actions: [
            GestureDetector(
              onTap: () {
                homeViewModel.loadCars();
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: ResColors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Icon(
                  Icons.refresh,
                  color: ResColors.mainColor,
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                homeViewModel.clearFilter();
                _searchSheet(context, homeViewModel);
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: ResColors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Icon(
                  Icons.search,
                  color: ResColors.mainColor,
                ),
              ),
            ),
            const SizedBox(width: 8),
            !kIsWeb
                ? GestureDetector(
                    onTap: () {
                      _scanQRCode(context, homeViewModel);
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: ResColors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Icon(
                        Icons.qr_code_scanner,
                        color: ResColors.mainColor,
                      ),
                    ),
                  )
                : Container(),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ),
                );
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: ResColors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Icon(
                  Icons.person,
                  color: ResColors.mainColor,
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: RefreshIndicator(
          backgroundColor: ResColors.mainBg,
          color: ResColors.mainColor,
          onRefresh: () async {
            homeViewModel.loadCars();
          },
          child: (homeViewModel.cars.isNotEmpty || homeViewModel.isLoading)
              ? ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: homeViewModel.scrollController,
                  itemCount:
                      homeViewModel.isLoading ? 10 : homeViewModel.cars.length,
                  itemBuilder: (context, position) {
                    return homeViewModel.isLoading
                        ? const CarItemShimmer()
                        : CarItem(
                            car: homeViewModel.cars[position],
                            onItemClick: () {
                              int? carId = homeViewModel.cars[position].id;
                              openDetail(context, carId, homeViewModel);
                            },
                          );
                  },
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
                          homeViewModel.loadCars();
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
        ),
      ),
    );
  }

  Future _searchSheet(BuildContext context, HomeViewModel homeViewModel) {
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
                  "search".tr(),
                  style: const TextStyle(
                    color: ResColors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  "model".tr(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: ResColors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  width: MediaQuery.sizeOf(context).width - 32,
                  decoration: const BoxDecoration(
                    color: ResColors.textFieldBg,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: homeViewModel.models.isNotEmpty
                      ? DropdownButtonFormField(
                          dropdownColor: ResColors.textFieldBg,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16),
                              ),
                            ),
                          ),
                          hint: Text(
                            "select".tr(),
                            style: const TextStyle(color: ResColors.black),
                          ),
                          items: homeViewModel.models
                              .map((e) => DropdownMenuItem(
                                  value: e, child: Text(e.title)))
                              .toList(),
                          onChanged: (value) {
                            homeViewModel.modelC.text = value?.title ?? "";
                          },
                        )
                      : Container(height: 60),
                ),
                const SizedBox(height: 16),
                Text(
                  "madeYear".tr(),
                  style: const TextStyle(
                    color: ResColors.black,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 56,
                        decoration: const BoxDecoration(
                            color: ResColors.textFieldBg,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: TextField(
                          controller: homeViewModel.startYear,
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.calendar_month),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            hintText: "minYear".tr(),
                            hintStyle: const TextStyle(
                              color: ResColors.black,
                            ),
                          ),
                          onTap: () {
                            _selectYear(context, homeViewModel).then((value) =>
                                {
                                  homeViewModel.startYear.text =
                                      value.toString()
                                });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: ResColors.textFieldBg,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: TextField(
                          controller: homeViewModel.finishYear,
                          readOnly: true,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.calendar_month),
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            hintText: "maxYear".tr(),
                            hintStyle: const TextStyle(color: ResColors.black),
                          ),
                          onTap: () {
                            _selectYear(context, homeViewModel).then((value) =>
                                {
                                  homeViewModel.finishYear.text =
                                      value.toString()
                                });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  "price".tr(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: ResColors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: ResColors.textFieldBg,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: TextField(
                          maxLength: 4,
                          controller: homeViewModel.startMoney,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            suffixText: "mln".tr(),
                            counterText: "",
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            hintText: "10",
                            hintStyle: const TextStyle(
                              color: ResColors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: ResColors.textFieldBg,
                            borderRadius:
                                BorderRadius.all(Radius.circular(16))),
                        child: TextField(
                          controller: homeViewModel.finishMoney,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          maxLength: 4,
                          decoration: InputDecoration(
                            suffixText: "mln".tr(),
                            counterText: "",
                            border: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            ),
                            hintText: "100",
                            hintStyle: const TextStyle(color: ResColors.black),
                          ),
                        ),
                      ),
                    ),
                  ],
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
                            homeViewModel.filterCars();
                            Navigator.pop(context);
                          },
                          child: Text(
                            "search".tr(),
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

  Future<int> _selectYear(
      BuildContext context, HomeViewModel homeViewModel) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "selectYear".tr(),
            style: const TextStyle(
              color: ResColors.black,
            ),
          ),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 30, 1),
              lastDate: DateTime(DateTime.now().year, 1),
              selectedDate: homeViewModel.selectedDate,
              onChanged: (DateTime dateTime) {
                homeViewModel.selectedDate = dateTime;
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
    return homeViewModel.selectedDate.year;
  }

  _scanQRCode(BuildContext context, HomeViewModel homeViewModel) async {
    final result = await Navigator.push<String>(
        context, MaterialPageRoute(builder: (context) => const Scanner()));
    if (result != null) {
      final index = result.lastIndexOf("=");
      final carId = int.tryParse(result.substring(index + 1));

      await Future.delayed(const Duration(milliseconds: 500));
      if (context.mounted) openDetail(context, carId, homeViewModel);
    }
  }

  openDetail(
      BuildContext context, int? carId, HomeViewModel homeViewModel) async {
    if (carId != null) {
      var res = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(carId: carId),
        ),
      );
      if (res == true) homeViewModel.loadCars();
    }
  }
}
