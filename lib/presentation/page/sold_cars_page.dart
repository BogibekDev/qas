import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qas/presentation/page/sold_detail_page.dart';

import '../../config/injection.dart';
import '../../tools/res_color.dart';
import '../viewmodel/sold_cars_viewmodel.dart';
import '../widget/car_item_shimmer.dart';
import '../widget/sold_car_item.dart';

final soldCarsNotifierProvider =
    ChangeNotifierProvider.autoDispose<SoldCarsViewmodel>((ref) {
  return SoldCarsViewmodel(ref.read(getSoldCars));
});

class SoldCarsPage extends ConsumerWidget {
  const SoldCarsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SoldCarsViewmodel viewModel = ref.watch(soldCarsNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ResColors.mainColor,
        title: Text(
          "Sotilgan moshinalar",
          style: const TextStyle(fontSize: 20, color: ResColors.white),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        backgroundColor: ResColors.mainBg,
        color: ResColors.mainColor,
        onRefresh: () async {},
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView.builder(
            controller: viewModel.scrollController,
            itemCount: viewModel.isLoading ? 10 : viewModel.cars.length,
            itemBuilder: (context, position) {
              return viewModel.isLoading
                  ? const CarItemShimmer()
                  : SoldCarItem(
                      car: viewModel.cars[position],
                      onItemClick: () {
                        int? carId = viewModel.cars[position].id;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SoldDetailPage(carId: carId!),
                          ),
                        );
                      },
                    );
            },
          ),
        ),
      ),
    );
  }
}
