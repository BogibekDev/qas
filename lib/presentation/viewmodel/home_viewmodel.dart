import 'package:flutter/material.dart';

import '../../config/base_vm.dart';
import '../../domain/entities/home/car.dart';
import '../../domain/entities/home/model.dart';
import '../../domain/use_cases/home/home_use_case.dart';

class HomeViewModel extends BaseViewModel {
  final HomeUseCase _homeUseCase;

  final TextEditingController rusumi = TextEditingController();
  final TextEditingController startYear = TextEditingController();
  final TextEditingController finishYear = TextEditingController();
  final TextEditingController startMoney = TextEditingController();
  final TextEditingController finishMoney = TextEditingController();
  final List<Car> cars = [];
  List<Model> rusums = [];
  String errorMessage = "";
  bool isLoading = false;
  DateTime selectedDate = DateTime(2024);

  HomeViewModel(this._homeUseCase) {
    loadCars(page: 1);
    loadModels();
  }

  void loadCars({int page = 1}) {
    Map<String, dynamic> queries = {
      "page": page,
    };
    _homeUseCase.execute(queries).listen((event) {
      event.when(
        loading: () {
          isLoading = true;
          notifyListeners();
        },
        content: (response) {
          if (response.success) {
            cars.addAll(response.data.results ?? []);
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

  void filterCars({int page = 1}) {
    Map<String, dynamic> queries = {
      "page": page,
      "model": rusumi.text,
      "min_year": startYear.text,
      "max_year": finishYear.text,
      "min_price": startMoney.text,
      "max_price": finishMoney.text
    };
    _homeUseCase.execute(queries).listen((event) {
      event.when(
        loading: () {
          isLoading = true;
          notifyListeners();
        },
        content: (response) {
          if (response.success) {
            cars.clear();
            cars.addAll(response.data.results ?? []);
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

  void loadModels() {
    _homeUseCase.modelsExecute().listen((event) {
      event.when(
        loading: () {},
        content: (response) {
          if (response.success) {
            rusums = response.data.results ?? [];
            notifyListeners();
          }
        },
        error: (error) {},
      );
    }).onDone(() {});
  }
}
