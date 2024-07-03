import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qas/data/local/prefs.dart';

import '../../config/injection.dart';
import '../../main.dart';
import '../../tools/res_color.dart';
import '../viewmodel/profile_viewmodel.dart';
import '../widget/car_item_shimmer.dart';
import '../widget/returned_car_item.dart';
import '../widget/sold_car_item.dart';
import 'returned_car_detail_page.dart';
import 'sold_detail_page.dart';

final profileNotifierProvider =
    ChangeNotifierProvider.autoDispose<ProfileViewmodel>((ref) {
  return ProfileViewmodel(
      ref.read(getSoldCars), ref.read(getReturnedCars), ref.read(getProfile));
});

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ProfileViewmodel viewModel;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ProfileViewmodel viewModel = ref.watch(profileNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: ResColors.white),
        backgroundColor: ResColors.mainColor,
        title: const Text(
          "Профиль",
          style: TextStyle(fontSize: 20, color: ResColors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            iconSize: 34,
            onPressed: () {
              SharedPrefs.clear();
              navigatorKey.currentState?.pushReplacementNamed("/login");
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              surfaceTintColor: ResColors.white,
              color: ResColors.white,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Шахсий маълумотлар",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ResColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          "Ф.И.Ш. :",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                            color: ResColors.black,
                            fontSize: 16,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${viewModel.profile.fullName}",
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: ResColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Телефон номер :",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                            color: ResColors.black,
                            fontSize: 16,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${viewModel.profile.phoneNumber}",
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: ResColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              surfaceTintColor: ResColors.white,
              color: ResColors.white,
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Статистика",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ResColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Text(
                          "Сотилган мошиналар: ",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                            color: ResColors.black,
                            fontSize: 16,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${viewModel.profile.soldCarsCount} та",
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: ResColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Қайтарилган машиналар :",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                            color: ResColors.black,
                            fontSize: 16,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${viewModel.profile.returnedCarsCount} та",
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: ResColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "Ойлик рейтинг :",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                            color: ResColors.black,
                            fontSize: 16,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            viewModel.profile.rating != null
                                ? "${viewModel.profile.rating}-ўринда"
                                : "Мавжуд эмас",
                            textAlign: TextAlign.end,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: ResColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Card(
                surfaceTintColor: ResColors.white,
                color: ResColors.white,
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Машиналар рўйҳати",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TabBar(
                        controller: _tabController,
                        tabs: const [
                          Tab(text: "Сотилган"),
                          Tab(text: "Қайтарилган"),
                        ],
                        labelColor: ResColors.white,
                        labelStyle: const TextStyle(fontSize: 18),
                        indicator: const BoxDecoration(
                            color: ResColors.mainColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        indicatorSize: TabBarIndicatorSize.tab,
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            ListView.builder(
                              controller: viewModel.scrollController,
                              itemCount: viewModel.isLoading
                                  ? 10
                                  : viewModel.cars.length,
                              itemBuilder: (context, position) {
                                return viewModel.isLoading
                                    ? const CarItemShimmer()
                                    : SoldCarItem(
                                        car: viewModel.cars[position],
                                        onItemClick: () {
                                          int? carId =
                                              viewModel.cars[position].id;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SoldDetailPage(carId: carId!),
                                            ),
                                          );
                                        },
                                      );
                              },
                            ),
                            ListView.builder(
                              itemCount: viewModel.returnedCars.length,
                              // Replace with your dynamic item count
                              itemBuilder: (context, index) {
                                return ReturnedCarItem(
                                  car: viewModel.returnedCars[index],
                                  onItemClick: () {
                                    int? carId =
                                        viewModel.returnedCars[index].id;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ReturnedCarDetailPage(
                                                carId: carId!),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
