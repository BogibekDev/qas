// import 'package:carousel_slider/carousel_controller.dart' as carousel;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../config/base_vm.dart';
import '../../domain/entities/detail/return.dart';
import '../../domain/entities/home/car.dart';
import '../../domain/entities/response/response.dart';
import '../../domain/use_cases/detail/car_return.dart';
import '../../domain/use_cases/detail/detail_use_case.dart';
import '../../tools/res_color.dart';
import '../widget/toast.dart';

class DetailViewModel extends BaseViewModel {
  final DetailUseCase _detailUseCase;
  final CarReturn _carReturn;
  late int id;
  Car car = Car();

  bool isActive = true;

  DetailViewModel(this._detailUseCase, this._carReturn, this.id) {
    loadCarDetail(id);
  }

  String errorMessage = "";
  String pdfUrl = "";
  bool isLoading = false;
  bool isReturnLoading = false;
  bool isReturned = false;
  int count401 = 0;
  final TextEditingController reasonController = TextEditingController();
  //final carousel.CarouselController carouselController = carousel.CarouselController();
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
        error: (Error? error) {
          toastError(error);
        },
      );
    }).onDone(
      () {
        isLoading = false;
        if (isActive) notifyListeners();
      },
    );
  }

  Color itemColor(i) {
    return carouselIndex == i ? ResColors.mainColor : ResColors.greyYellow;
  }

  void returnCar(Function onCallBack) {
    final returnRequest = Return(id, reasonController.text.toString());
    _carReturn.execute(returnRequest).listen((event) {
      event.when(
        loading: () {
          isReturnLoading = true;
          notifyListeners();
        },
        content: (response) async {
          if (response.success) {
            var res = await openPDF(response.data.pdfLink ?? "");
            if (res == true) {
              isReturned = true;
              onCallBack.call();
              notifyListeners();
            }
          }
        },
        error: (Error? error) {
          toastError(error);
        },
      );
    }).onDone(
      () {
        isReturnLoading = false;
        notifyListeners();
      },
    );
  }

  Future<bool> openPDF(String url) async {
    return await launchUrlString(url);
  }

  @override
  void dispose() {
    isActive = false;
    super.dispose();
  }
}
