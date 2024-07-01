import 'package:flutter/material.dart';

import '../../config/base_vm.dart';
import '../../domain/entities/home/car.dart';
import '../../domain/use_cases/sold/get_sold_cars.dart';
import '../widget/toast.dart';

class SoldCarsViewmodel extends BaseViewModel {
  final GetSoldCars _getSoldCars;
  bool isLoading = false;
  bool hasNext = true;
  final List<Car> cars = [];
  bool isMoreLoading = false;
  final ScrollController scrollController = ScrollController();

  SoldCarsViewmodel(this._getSoldCars) {
    getSoldCars();
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
}
