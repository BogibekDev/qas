import 'package:flutter/material.dart';

import '../../config/base_vm.dart';
import '../../domain/entities/home/car.dart';
import '../../domain/entities/home/model.dart';
import '../../domain/entities/response/response.dart';
import '../../domain/use_cases/home/get_models.dart';
import '../../domain/use_cases/home/home_use_case.dart';
import '../widget/toast.dart';

class HomeViewModel extends BaseViewModel {
  final GetCars _getCars;
  final GetModels _getModels;

  final TextEditingController modelC = TextEditingController();
  final TextEditingController startYear = TextEditingController();
  final TextEditingController finishYear = TextEditingController();
  final TextEditingController startMoney = TextEditingController();
  final TextEditingController finishMoney = TextEditingController();
  DateTime selectedDate = DateTime(2024);
  final ScrollController scrollController = ScrollController();
  int page = 1;
  int filterPage = 1;
  final List<Car> cars = [];
  List<Model> models = [];
  bool isLoading = false;
  bool isMoreLoading = false;
  bool hasNext = true;
  bool isFilter = false;
  Error? error;


  HomeViewModel(this._getCars, this._getModels) {
    loadCars();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasNext) {
        isFilter ? loadMoreCars() : loadMoreCars();
      }
    });
  }

  void loadCars() {
    isFilter = false;
    Map<String, dynamic> queries = {
      "page": page,
    };
    cars.clear();
    _getCars.execute(queries).listen((event) {
      event.when(
        loading: () {
          isLoading = true;
          notifyListeners();
        },
        content: (response) {
          if (response.success) {
            cars.addAll(response.data.results ?? []);
            hasNext = response.data.next != null;
            loadModels();
          }
        },
        error: (Error? error) {
          this.error = error;
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

  void loadMoreCars() {
    isFilter = false;
    page++;
    Map<String, dynamic> queries = {
      "page": page,
    };
    _getCars.execute(queries).listen((event) {
      event.when(
        loading: () {
          isMoreLoading = true;
          notifyListeners();
        },
        content: (response) {
          if (response.success) {
            cars.addAll(response.data.results ?? []);
            hasNext = response.data.next != null;
          }
        },
        error: (Error? error) {
          toastError(error);
        },
      );
    }).onDone(
      () {
        isMoreLoading = false;
        notifyListeners();
      },
    );
  }

  void filterCars() {
    isFilter = true;
    Map<String, dynamic> queries = {
      "page": filterPage,
      "model": modelC.text,
      "min_year": startYear.text,
      "max_year": finishYear.text,
      "min_price": startMoney.text,
      "max_price": finishMoney.text
    };
    _getCars.execute(queries).listen((event) {
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

  void filterMoreCars() {
    isFilter = true;
    Map<String, dynamic> queries = {
      "page": filterPage,
      "model": modelC.text,
      "min_year": startYear.text,
      "max_year": finishYear.text,
      "min_price": startMoney.text,
      "max_price": finishMoney.text
    };
    _getCars.execute(queries).listen((event) {
      event.when(
        loading: () {
          isLoading = true;
          notifyListeners();
        },
        content: (response) {
          if (response.success) {
            cars.addAll(response.data.results ?? []);
            hasNext = response.data.next != null;
          }
        },
        error: (error) {
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

  void loadModels() {
    _getModels.execute().listen((event) {
      event.when(
        loading: () {},
        content: (response) {
          if (response.success) {
            models = response.data.results ?? [];
            notifyListeners();
          }
        },
        error: (error) {},
      );
    }).onDone(() {});
  }
}
