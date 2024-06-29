import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../config/base_vm.dart';
import '../../domain/entities/home/car.dart';
import '../../domain/entities/response/response.dart';
import '../../domain/entities/sell/buyer.dart';
import '../../domain/entities/sell/sell_request.dart';
import '../../domain/use_cases/detail/detail_use_case.dart';
import '../../domain/use_cases/sell/add_buyer.dart';
import '../../domain/use_cases/sell/getBuyers.dart';
import '../../domain/use_cases/sell/sell_car.dart';
import '../../tools/utils.dart';
import '../widget/toast.dart';

class SellViewModel extends BaseViewModel {
  final GetBuyers _getBuyers;
  final DetailUseCase _detailUseCase;
  final AddBuyer _addBuyer;
  final SellCar _sellCar;

  final TextEditingController buyerController = TextEditingController();
  final TextEditingController compensationC = TextEditingController();
  final TextEditingController prePriceC = TextEditingController();
  final TextEditingController periodC = TextEditingController();
  final TextEditingController pricePerMC = TextEditingController();
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
  late Car car;
  Buyer? selectedBuyer;
  String paymentType = "";

  FocusNode focusNode = FocusNode();
  bool isFocused = false;
  bool isNoBuyer = false;
  List<String> paymentTypes = ["cash", "credit"];

  String errorMessage = "";
  bool isLoading = false;
  bool carLoading = false;
  bool isRefresh = false;
  int count401 = 0;
  List<Buyer> buyers = [];

  SellViewModel(
      this._getBuyers, this._detailUseCase, this._addBuyer, this._sellCar) {
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
          }
        },
        error: (Error? error) {
            toastError(error);
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
            priceC.text = double.tryParse(response.data.price ?? "0.0")!
                .toInt()
                .toString()
                .addSpace();
            prePriceC.text = double.tryParse(response.data.prePrice ?? "0.0")!
                .toInt()
                .toString()
                .addSpace();
            periodC.text = car.period.toString();
            pricePerMC.text =
                double.tryParse(response.data.pricePerMonth ?? "0.0")!
                    .toInt()
                    .toString()
                    .addSpace();
            ;
          }
        },
        error: (Error? error) {
            toastError(error);
        },
      );
    }).onDone(
      () {
          carLoading = false;
          notifyListeners();
      },
    );
  }

  void addBuyer(Function onCallBack) {
    final String firstName = buyerFirstName.text.trim();
    final String lastName = buyerLastName.text.trim();
    final String middleName = buyerMiddleName.text.trim();
    final String birthYear = buyerBirthday.text.trim();
    final String passport = buyerPassport.text.trim();
    final String address = buyerAddress.text.trim();
    final String phoneNumber = buyerPhoneNumber.text.trim();
    final String extraPhoneNumber = buyerExtraPhoneNumber.text.trim();

    if (firstName.isNotEmpty &&
        lastName.isNotEmpty &&
        middleName.isNotEmpty &&
        birthYear.length == 10 &&
        passport.length == 9 &&
        address.isNotEmpty &&
        phoneNumber.length == 9) {
      final buyer = Buyer(
          null,
          firstName,
          lastName,
          middleName,
          birthYear,
          passport,
          address,
          "+998$phoneNumber",
          extraPhoneNumber.isNotEmpty ? "+998$extraPhoneNumber" : null);
      _addBuyer.execute(buyer).listen((event) {
        event.when(
          loading: () {
            carLoading = true;
            notifyListeners();
          },
          content: (response) {
            if (response.success) {
              selectedBuyer = response.data;
              onCallBack.call();
            }
          },
          error: (Error? error) {
            toastError(error);
          }
        );
      }).onDone(
        () {
            carLoading = false;
            notifyListeners();
        },
      );
    } else {
      toastError(Error.empty()..message = "Hamma maydonni to'ldiring!");
    }
  }

  void sellCar(Function onCallBack) {
    final String price = priceC.text.removeSpace();
    final String compensationPrice = compensationC.text.removeSpace();
    final String prePrice = prePriceC.text.removeSpace();
    final String pricePerMonth = pricePerMC.text.removeSpace();
    final String period = periodC.text.removeSpace();

    if (price.length > 1 &&
        compensationPrice.length > 1 &&
        selectedBuyer != null &&
        paymentType.isNotEmpty) {
      final request = SellRequest(carId, selectedBuyer, price,
          compensationPrice, paymentType, prePrice, pricePerMonth, period);

      _sellCar.execute(request).listen((event) {
        event.when(
          loading: () {
            carLoading = true;
            notifyListeners();
          },
          content: (response) async {
            if (response.success) {
              var res = await openPDF(response.data.contract ?? "");
              if (res == true) onCallBack.call();
            }
          },
          error: (Error? error) {
              toastError(error);
          },
        );
      }).onDone(
        () {
            carLoading = false;
            notifyListeners();
        },
      );
    } else {
      toastError(Error.empty()..message = "Hamma maydonni to'ldiring!");
    }
  }

  void selectBuyer(int position) {
    selectedBuyer = buyers[position];
    buyerController.text =
        "${selectedBuyer?.firstName} ${selectedBuyer?.lastName} ${selectedBuyer?.middleName}";
    focusNode.unfocus();
    notifyListeners();
  }

  void changePaymentType(String type) {
    paymentType = type;
    notifyListeners();
  }

  Future<bool> openPDF(String url) async {
    return await launchUrlString(url);
  }
}
