import 'package:flutter/material.dart';
import 'package:qas/tools/utils.dart';

import '../../config/base_vm.dart';
import '../../domain/entities/home/car.dart';
import '../../domain/entities/sell/buyer.dart';
import '../../domain/use_cases/detail/detail_use_case.dart';
import '../../domain/use_cases/sell/getBuyers.dart';

class SellViewModel extends BaseViewModel {
  final GetBuyers _getBuyers;
  final DetailUseCase _detailUseCase;
  late Car car;
  Buyer? selectedBuyer;

  final TextEditingController buyerController = TextEditingController();
  final TextEditingController compensationC = TextEditingController();
  final TextEditingController prePriceC = TextEditingController();
  final TextEditingController periodC = TextEditingController();
  final TextEditingController remainingPriceC = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController buyerFirstName = TextEditingController();
  final TextEditingController buyerLastName = TextEditingController();
  final TextEditingController buyerMiddleName = TextEditingController();
  final TextEditingController buyerBirthday = TextEditingController();
  final TextEditingController buyerPassport = TextEditingController();
  final TextEditingController buyerAddress = TextEditingController();
  final TextEditingController buyerPhoneNumber = TextEditingController();
  final TextEditingController buyerExtraPhoneNumber = TextEditingController();
  int carId = 1;

  FocusNode focusNode = FocusNode();
  bool isFocused = false;
  bool isNoBuyer = false;
  List<String> paymentTypes = ["cash", "credit"];
  String paymentType = "";

  String errorMessage = "";
  bool isLoading = false;
  bool carLoading = false;
  List<Buyer> buyers = [];

  SellViewModel(this._getBuyers, this._detailUseCase) {
    searchBuyers(null);
    focusNode.addListener(() {
      isFocused = focusNode.hasFocus;
      notifyListeners();
    });
  }

  void searchBuyers(String? search) {
    _getBuyers.execute(search).listen((event) {
      event.when(
        loading: () {
          isLoading = true;
          notifyListeners();
        },
        content: (response) {
          if (response.success) {
            buyers.clear();
            buyers.addAll(response.data.results!);
            if (buyers.isEmpty) {
              isNoBuyer = true;
            } else {
              isNoBuyer = false;
            }
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

  void loadCarDetail(int id) {
    _detailUseCase.execute(id).listen((event) {
      event.when(
        loading: () {
          carLoading = true;
          notifyListeners();
        },
        content: (response) {
          if (response.success) {
            car = response.data;
            priceC.text = double.tryParse(response.data.price??"0.0")!.toInt().toString().addSpace();
            prePriceC.text = double.tryParse(response.data.prePrice??"0.0")!.toInt().toString().addSpace();
            periodC.text = car.period.toString();
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
        carLoading = false;
        notifyListeners();
      },
    );
  }

  void selectBuyer(int position) {
    selectedBuyer = buyers[position];
    buyerController.text =
        "${selectedBuyer?.firstName} ${selectedBuyer?.lastName}";
    focusNode.unfocus();
    notifyListeners();
  }

  void changePaymentType(String type) {
    paymentType = type;
    notifyListeners();
  }
}
