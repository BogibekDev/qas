import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../config/base_vm.dart';
import '../../domain/entities/detail/return.dart';
import '../../domain/entities/home/car.dart';
import '../../domain/entities/response/response.dart';
import '../../domain/use_cases/detail/car_return.dart';
import '../../domain/use_cases/detail/detail_use_case.dart';
import '../../main.dart';
import '../../tools/res_color.dart';
import '../widget/toast.dart';
import 'refresh_token.dart';

class DetailViewModel extends BaseViewModel {
  final DetailUseCase _detailUseCase;
  final CarReturn _carReturn;
  late int id;
  Car car = Car();

  DetailViewModel(this._detailUseCase, this._carReturn, this.id) {
    loadCarDetail(id);
  }

  String errorMessage = "";
  String pdfUrl = "";
  bool isLoading = false;
  bool isReturnLoading = false;
  bool isRefresh = false;
  int count401 = 0;
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
        error: (Error? error) async {
          if (error?.statusCode == 401 &&
              error!.detail == "Token has expired") {
            count401++;
            if (count401 == 2) {
              navigatorKey.currentState?.pushReplacementNamed("/login");
            }
            isRefresh = true;
            RefreshToken().execute(
              err: error,
              callBack: () {
                isRefresh = false;
                loadCarDetail(id);
              },
            );
          }
          if (!isRefresh) {
            toastError(error);
          }
        },
      );
    }).onDone(
      () {
        if (!isRefresh) {
          isLoading = false;
          notifyListeners();
        }
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
          }
        },
        error: (Error? error) async {
          if (error?.statusCode == 401 &&
              error!.detail == "Token has expired") {
            count401++;
            if (count401 == 2) {
              navigatorKey.currentState?.pushReplacementNamed("/login");
            }
            isRefresh = true;
            RefreshToken().execute(
              err: error,
              callBack: () {
                isRefresh = false;
                returnCar();
              },
            );
          }
          if (!isRefresh) {
            toastError(error);
          }
        },
      );
    }).onDone(
      () {
        if (!isRefresh) {
          isReturnLoading = false;
          notifyListeners();
        }
      },
    );
  }

  Future<void> openPDF(String url) async {
    await launchUrlString(url);
  }
}
