import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:qas/presentation/widget/toast.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../config/base_vm.dart';
import '../../domain/entities/detail/return.dart';
import '../../domain/entities/home/car.dart';
import '../../domain/use_cases/detail/car_return.dart';
import '../../domain/use_cases/detail/detail_use_case.dart';
import '../../tools/res_color.dart';

class DetailViewModel extends BaseViewModel {
  final DetailUseCase _detailUseCase;
  final CarReturn _carReturn;
  int id = 1;
  Car car = Car();

  DetailViewModel(this._detailUseCase, this._carReturn) {
    loadWithDelay();
  }

  String errorMessage = "";
  String pdfUrl = "";
  bool isLoading = false;
  bool isReturnLoading = false;
  final TextEditingController reasonController = TextEditingController();
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
    isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    loadCarDetail(id);
  }

  void returnCar() {
    final returnRequest = Return(id, reasonController.text.toString());
    _carReturn.execute(returnRequest).listen((event) {
      event.when(
        loading: () {
          isReturnLoading = true;
          notifyListeners();
        },
        content: (response) {
          if (response.success) {
            pdfUrl = response.data.pdfLink ?? "";
            openPDF(pdfUrl);
          } else {
            errorMessage = response.error?.message ?? "";
            toastError(errorMessage);
          }
        },
        error: (error) {
          errorMessage = error ?? "";
          toastError(errorMessage);
        },
      );
    }).onDone(
      () {
        isReturnLoading = false;
        notifyListeners();
      },
    );
  }

  Future<void> openPDF(String url) async {
    await launchUrlString(url);
  }
}
