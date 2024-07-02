import '../../config/base_vm.dart';
import '../../domain/entities/sold_car/sold_car.dart';
import '../../domain/use_cases/sold_detail/get_sold_car.dart';
import '../widget/toast.dart';

class SoldDetailViewModel extends BaseViewModel {
  final GetSoldCar _getsoldCar;

  SoldDetailViewModel(this._getsoldCar, this.id) {
    loadSoldCarDetail(id);
  }

  bool isLoading = false;
  late int id;
  late SoldCar soldCar;

  void loadSoldCarDetail(int id) {
    _getsoldCar.execute(id).listen((event) {
      event.when(
        loading: () {
          isLoading = true;
          notifyListeners();
        },
        content: (response) {
          if (response.success) {
            soldCar = response.data;
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
