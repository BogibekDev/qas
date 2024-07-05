import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/injection.dart';
import '../../tools/currency_input_formatter.dart';
import '../../tools/date_formatter.dart';
import '../../tools/res_color.dart';
import '../viewmodel/sell_viewmodel.dart';
import 'home_page.dart';

final sellNotifierProvider =
    ChangeNotifierProvider.autoDispose<SellViewModel>((ref) {
  return SellViewModel(ref.read(getBuyers), ref.read(detailUseCase),
      ref.read(addBuyer), ref.read(sellCar));
});

class SellPage extends ConsumerStatefulWidget {
  const SellPage({super.key, required this.carId});

  final int carId;

  @override
  _SellPageState createState() => _SellPageState();
}

class _SellPageState extends ConsumerState<SellPage> {
  late SellViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = ref.read(sellNotifierProvider);
    viewModel.carId = widget.carId;
    viewModel.loadCarDetail(widget.carId);
  }

  @override
  Widget build(BuildContext context) {
    SellViewModel viewModel = ref.watch(sellNotifierProvider);

    return Scaffold(
      backgroundColor: ResColors.mainBg,
      appBar: AppBar(
        backgroundColor: ResColors.mainBg,
        title: Text(
          "enterFields".tr(),
          style: const TextStyle(color: ResColors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    "buyerInfo".tr(),
                    style: const TextStyle(
                      color: ResColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // some views
                  TextFormField(
                    controller: viewModel.buyerFirstName,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      border: const OutlineInputBorder(),
                      hintText: "firstName".tr(),
                      label: Text("firstName".tr()),
                    ),
                    style: const TextStyle(
                      color: ResColors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: viewModel.buyerLastName,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      border: const OutlineInputBorder(),
                      hintText: "lastName".tr(),
                      label: Text("lastName".tr()),
                    ),
                    style: const TextStyle(
                      color: ResColors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: viewModel.buyerMiddleName,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      border: const OutlineInputBorder(),
                      hintText: "middleName".tr(),
                      label: Text("middleName".tr()),
                    ),
                    style: const TextStyle(
                      color: ResColors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: viewModel.buyerBirthday,
                    keyboardType: TextInputType.number,
                    inputFormatters: [DateInputFormatter()],
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      border: const OutlineInputBorder(),
                      hintText: "12-04-2004",
                      label: Text("birthday".tr()),
                    ),
                    style: const TextStyle(
                      color: ResColors.black,
                      fontSize: 20,
                    ),
                  ),

                  const SizedBox(height: 16),
                  TextFormField(
                    controller: viewModel.buyerPassport,
                    textInputAction: TextInputAction.next,
                    maxLength: 9,
                    decoration: InputDecoration(
                      filled: true,
                      counterText: "",
                      fillColor: ResColors.textFieldBg,
                      border: const OutlineInputBorder(),
                      hintText: "AA1234567",
                      label: Text("passport".tr()),
                    ),
                    style: const TextStyle(
                      color: ResColors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    controller: viewModel.buyerPassportDate,
                    keyboardType: TextInputType.number,
                    inputFormatters: [DateInputFormatter()],
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      border: OutlineInputBorder(),
                      hintText: "12-04-2004",
                      label: Text("Пасспорт берилган сана"),
                    ),
                    style: const TextStyle(
                      color: ResColors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: viewModel.buyerAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      border: const OutlineInputBorder(),
                      hintText: "address".tr(),
                      label: Text("address".tr()),
                    ),
                    style: const TextStyle(
                      color: ResColors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: viewModel.buyerPhoneNumber,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      hintText: "901234567",
                      counterText: "",
                      labelText: "phoneNumber".tr(),
                      border: const OutlineInputBorder(),
                      prefix: const Text(
                        "+998  ",
                        style: TextStyle(
                          fontSize: 18,
                          color: ResColors.black,
                        ),
                      ),
                    ),
                    maxLength: 9,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 18,
                      color: ResColors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: viewModel.buyerExtraPhoneNumber,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      hintText: "901234567",
                      counterText: "",
                      labelText: "extraPhoneNumber".tr(),
                      border: const OutlineInputBorder(),
                      prefix: const Text(
                        "+998  ",
                        style: TextStyle(
                          fontSize: 18,
                          color: ResColors.black,
                        ),
                      ),
                    ),
                    maxLength: 9,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 18,
                      color: ResColors.black,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "carInfo".tr(),
                    style: const TextStyle(
                      color: ResColors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 18),

                  TextFormField(
                    controller: viewModel.priceC,
                    textInputAction: TextInputAction.next,
                    maxLength: 15,
                    inputFormatters: [CurrencyInputFormatter()],
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      counterText: "",
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      border: const OutlineInputBorder(),
                      hintText: "100 000 000",
                      suffixText: "sum".tr(),
                      label: Text("carPrice".tr()),
                    ),
                    style: const TextStyle(
                      color: ResColors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: viewModel.compensationC,
                    textInputAction: TextInputAction.next,
                    maxLength: 15,
                    keyboardType: TextInputType.number,
                    inputFormatters: [CurrencyInputFormatter()],
                    decoration: InputDecoration(
                      counterText: "",
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      border: const OutlineInputBorder(),
                      hintText: "100 000 000",
                      suffixText: "sum".tr(),
                      label: Text("compensation".tr()),
                    ),
                    style: const TextStyle(
                      color: ResColors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  viewModel.paymentTypes.isNotEmpty
                      ? DropdownButtonFormField(
                          dropdownColor: ResColors.textFieldBg,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: ResColors.textFieldBg,
                            border: OutlineInputBorder(),
                          ),
                          hint: Text("selectPaymentType".tr()),
                          items: viewModel.paymentTypes
                              .map((item) => DropdownMenuItem(
                                    value: item,
                                    child: Text(
                                      item.tr(),
                                      style: const TextStyle(fontSize: 20),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            viewModel.changePaymentType(value ?? "cash");
                          },
                        )
                      : Container(),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: viewModel.extraComment,
                    maxLines: 2,
                    textInputAction: TextInputAction.next,
                    decoration:const  InputDecoration(
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      border: OutlineInputBorder(),
                      hintText: "Қўшимча изоҳ",
                      label: Text("Қўшимча изоҳ"),
                    ),
                    style: const TextStyle(
                      color: ResColors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width,
                    height: 60,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ResColors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        viewModel.sellCar(() {
                          Navigator.pop(context, true);
                        });
                      },
                      child: viewModel.carLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Text(
                              "sell".tr(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: ResColors.white,
                                fontSize: 18,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void goHomePage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }
}
