import 'package:qas/presentation/widget/toast.dart';

import '../../config/base_vm.dart';
import '../../domain/entities/profile/returned_detail.dart';
import '../../domain/use_cases/profile/get_returned_car.dart';

class ReturnedDetailViewModel extends BaseViewModel {
  final GetReturnedCar _getReturnedCar;
  late int id;
  bool isLoading = false;
  ReturnedDetail returned = ReturnedDetail();

  ReturnedDetailViewModel(this._getReturnedCar, this.id) {
    getDetail(id);
  }

  void getDetail(int id) {
    _getReturnedCar.execute(id).listen((event) {
      event.when(
        loading: () {
          isLoading = true;
          notifyListeners();
        },
        content: (response) {
          if (response.success) {
            returned = response.data;
          } else {
            toastError(response.error);
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
}
