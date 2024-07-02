import 'package:flutter/material.dart';
import 'package:qas/domain/entities/profile/returned.dart';

import '../../config/base_vm.dart';
import '../../domain/entities/home/car.dart';
import '../../domain/use_cases/profile/get_returned_cars.dart';
import '../../domain/use_cases/sold/get_sold_cars.dart';
import '../widget/toast.dart';

class ProfileViewmodel extends BaseViewModel {
  final GetSoldCars _getSoldCars;
  final GetReturnedCars _getReturnedCars;
  bool isLoading = false;
  bool isReturnedLoading = false;
  bool hasNext = true;
  bool hasNextReturned = true;
  final List<Car> cars = [];
  final List<Returned> returnedCars = [];
  bool isMoreLoading = false;
  final ScrollController scrollController = ScrollController();

  ProfileViewmodel(this._getSoldCars, this._getReturnedCars) {
    getSoldCars();
    getReturnedCars();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasNext) {
        getSoldCars();
      }
    });
  }

  void getSoldCars() {
    _getSoldCars.execute(100).listen((event) {
      event.when(
        loading: () {
          isLoading = true;
          notifyListeners();
        },
        content: (response) {
          cars.addAll(response.data.results ?? []);
          hasNext = response.data.next != null;
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

  void getReturnedCars() {
    _getReturnedCars.execute().listen(
      (event) {
        event.when(
          loading: () {
            isReturnedLoading = true;
            notifyListeners();
          },
          content: (response) {
            if (response.success) {
              returnedCars.addAll(response.data.results ?? []);
              hasNextReturned = response.data.next != null;
            }
          },
          error: (error) {
            toastError(error);
          },
        );
      },
    ).onDone(
      () {
        isReturnedLoading = false;
        notifyListeners();
      },
    );
  }
}
