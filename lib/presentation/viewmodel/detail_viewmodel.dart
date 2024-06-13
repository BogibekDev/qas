import 'dart:ui';

import 'package:carousel_slider/carousel_controller.dart';

import '../../config/base_vm.dart';
import '../../domain/entities/home/car.dart';
import '../../domain/use_cases/detail/detail_use_case.dart';
import '../../tools/res_color.dart';

class DetailViewModel extends BaseViewModel {
  final DetailUseCase _detailUseCase;
  int id = 1;
  Car car = Car();

  DetailViewModel(this._detailUseCase) {
    loadWithDelay();
  }

  String errorMessage = "";
  bool isLoading = false;
  final CarouselController carouselController = CarouselController();
  int _carouselIndex = 0;

  int get carouselIndex => _carouselIndex;

  set carouselIndex(int index) {
    _carouselIndex = index;
    notifyListeners();
  }

  void loadCarDetail(int id) {
    _detailUseCase.execute(id).listen((event) {
      event.when(
        loading: () {
          isLoading = true;
          notifyListeners();
        },
        content: (response) {
          if (response.success) {
            car = response.data;
          } else {
            errorMessage = response.error?.message ?? "";
          }
        },
        error: (error) {
          errorMessage = error ?? "";
        },
      );
    }).onDone(
      () {
        isLoading = false;
        notifyListeners();
      },
    );
  }

  Color itemColor(i) {
    return carouselIndex == i ? ResColors.mainColor : ResColors.greyYellow;
  }

  void loadWithDelay() async {
    await Future.delayed(const Duration(seconds: 2));
    loadCarDetail(id);
  }
}
