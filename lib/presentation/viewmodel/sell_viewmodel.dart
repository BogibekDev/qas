import 'package:flutter/material.dart';

import '../../config/base_vm.dart';
import '../../domain/entities/sell/buyer.dart';
import '../../domain/use_cases/sell/getBuyers.dart';

class SellViewModel extends BaseViewModel {
  final GetBuyers _getBuyers;
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

  FocusNode focusNode = FocusNode();
  bool isFocused = false;
  bool isNoBuyer = false;
  List<String> paymentTypes = ["cash", "credit"];
  String paymentType = "";

  String errorMessage = "";
  bool isLoading = false;
  List<Buyer> buyers = [];

  SellViewModel(this._getBuyers) {
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

  void selectBuyer(int position) {
    selectedBuyer = buyers[position];
    buyerController.text =
        "${selectedBuyer?.firstName} ${selectedBuyer?.lastName}";
    focusNode.unfocus();
    notifyListeners();
  }
}
