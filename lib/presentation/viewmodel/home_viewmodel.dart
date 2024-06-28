import 'package:flutter/material.dart';

import '../../config/base_vm.dart';
import '../../domain/entities/home/car.dart';
import '../../domain/entities/home/model.dart';
import '../../domain/entities/response/response.dart';
import '../../domain/use_cases/home/get_models.dart';
import '../../domain/use_cases/home/home_use_case.dart';
import '../../main.dart';
import '../widget/toast.dart';
import 'refresh_token.dart';

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
  String errorMessage = "";
  bool isLoading = false;
  bool isMoreLoading = false;
  bool isRefresh = false;
  bool hasNext = true;
  int count401 = 0;

  HomeViewModel(this._getCars, this._getModels) {
    loadCars();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasNext) {
        loadMoreCars();
      }
    });
  }

  void loadCars() {
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
        error: (Error? error) async {
          if (error?.statusCode == 401) {
            count401++;
            if (count401 == 2) {
              navigatorKey.currentState?.pushReplacementNamed("/login");
            }
            isRefresh = true;
            RefreshToken().execute(
              err: error,
              callBack: () {
                isRefresh = false;
                loadCars();
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

  void loadMoreCars() {
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
        error: (Error? error) async {
          if (error?.statusCode == 401) {
            isRefresh = true;
            RefreshToken().execute(
              err: error,
              callBack: () {
                isRefresh = false;
                loadMoreCars();
              },
            );
          }
          toastError(error);
        },
      );
    }).onDone(
      () {
        if (!isRefresh) {
          isMoreLoading = false;
          notifyListeners();
        }
      },
    );
  }

  void filterCars() {
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
        error: (error) async {
          if (error?.statusCode == 401 &&
              error?.detail == "Token has expired") {
            count401++;
            if (count401 == 2) {
              navigatorKey.currentState?.pushReplacementNamed("/login");
            }
            isRefresh = true;
            RefreshToken().execute(
              err: error,
              callBack: () {
                isRefresh = false;
                filterCars();
              },
            );
          }
          toastError(error);
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
