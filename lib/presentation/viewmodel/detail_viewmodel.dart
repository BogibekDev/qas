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

  DetailViewModel(this._detailUseCase);

  String errorMessage = "";
  bool isLoading = false;
  final CarouselController carouselController = CarouselController();
  int _caruselIndex = 0;
  int get caruselIndex => _caruselIndex;
  set caruselIndex(int index) {
    _caruselIndex = index;
    notifyListeners();
  }

  void loadCarDetail(id) {
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
    return caruselIndex == i ? ResColors.mainColor : ResColors.greyYellow;
  }
}
