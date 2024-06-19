import 'package:flutter/material.dart';
import 'package:qas/presentation/widget/toast.dart';

import '../../config/base_vm.dart';
import '../../data/local/prefs.dart';
import '../../domain/entities/home/car.dart';
import '../../domain/entities/home/model.dart';
import '../../domain/use_cases/home/home_use_case.dart';
import '../../main.dart';
import 'refresh_token.dart';

class HomeViewModel extends BaseViewModel {
  final HomeUseCase _homeUseCase;

  final TextEditingController rusumi = TextEditingController();
  final TextEditingController startYear = TextEditingController();
  final TextEditingController finishYear = TextEditingController();
  final TextEditingController startMoney = TextEditingController();
  final TextEditingController finishMoney = TextEditingController();
  DateTime selectedDate = DateTime(2024);
  final ScrollController scrollController = ScrollController();
  int page = 1;
  int filterPage = 1;
  final List<Car> cars = [];
  List<Model> rusums = [];
  String errorMessage = "";
  bool isLoading = false;
  bool isMoreLoading = false;
  bool isRefresh = false;
  bool hasNext = true;
  int count401 = 0;

  HomeViewModel(this._homeUseCase) {
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
    _homeUseCase.execute(queries).listen((event) {
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
        error: (error) async {
          if (error?.contains("401") == true &&
              error!.contains("Token has expired")) {
            await SharedPrefs.removeToken();
            count401++;
            if (count401 == 2) {
              navigatorKey.currentState?.pushReplacementNamed("/login");
            }
            final refresh = await SharedPrefs.getRefreshToken();
            isRefresh = true;
            RefreshToken().execute(
              refresh: refresh,
              callBack: () {
                isRefresh = false;
                loadCars();
              },
            );
          }
          if(!isRefresh) {
            errorMessage = error ?? "";
            toastError(errorMessage);
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
    _homeUseCase.execute(queries).listen((event) {
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
        error: (error) async {
          if (error?.contains("401") == true) {
            final refresh = await SharedPrefs.getRefreshToken();
            await SharedPrefs.removeToken();
            isRefresh = true;
            RefreshToken().execute(
              refresh: refresh,
              callBack: () {
                isRefresh = false;
                loadMoreCars();
              },
            );
          }
          errorMessage = error ?? "";
        },
      );
    }).onDone(
      () {
        if(!isRefresh){
          isMoreLoading = false;
          notifyListeners();
        }
      },
    );
  }

  void filterCars() {
    Map<String, dynamic> queries = {
      "page": filterPage,
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
        error: (error) async{
          if (error?.contains("401") == true &&
              error!.contains("Token has expired")) {
            await SharedPrefs.removeToken();
            count401++;
            if (count401 == 2) {
              navigatorKey.currentState?.pushReplacementNamed("/login");
            }
            final refresh = await SharedPrefs.getRefreshToken();
            isRefresh = true;
            RefreshToken().execute(
              refresh: refresh,
              callBack: () {
                isRefresh = false;
                filterCars();
              },
            );
          }
          errorMessage = error ?? "";
        },
      );
    }).onDone(
      () {
        if(!isRefresh){
          isLoading = false;
          notifyListeners();
        }
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
