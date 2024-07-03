import 'package:flutter/material.dart';

import '../../config/base_vm.dart';
import '../../domain/entities/home/car.dart';
import '../../domain/entities/profile/profile.dart';
import '../../domain/entities/profile/returned.dart';
import '../../domain/use_cases/profile/get_profile.dart';
import '../../domain/use_cases/profile/get_returned_cars.dart';
import '../../domain/use_cases/sold/get_sold_cars.dart';
import '../widget/toast.dart';

class ProfileViewmodel extends BaseViewModel {
  final GetSoldCars _getSoldCars;
  final GetReturnedCars _getReturnedCars;
  final GetProfile _getProfile;
  bool isLoading = false;
  Profile profile = Profile();
  bool isReturnedLoading = false;
  bool isProfileLoading = false;
  bool hasNext = true;
  bool hasNextReturned = true;
  final List<Car> cars = [];
  final List<Returned> returnedCars = [];
  bool isMoreLoading = false;
  final ScrollController scrollController = ScrollController();

  ProfileViewmodel(this._getSoldCars, this._getReturnedCars, this._getProfile) {
    getSoldCars();
    getReturnedCars();
    getProfile();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          hasNext) {
        getSoldCars();
      }
    });
  }

  void getProfile() {
    _getProfile.execute().listen((event) {
      event.when(
        loading: () {
          isProfileLoading = true;
          notifyListeners();
        },
        content: (response) {
          if (response.success) {
            profile = response.data;
          }
        },
        error: (error) {
          toastError(error);
        },
      );
    }).onDone(
      () {
        isProfileLoading = false;
        notifyListeners();
      },
    );
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
