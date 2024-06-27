import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/injection.dart';
import '../../tools/currency_input_formatter.dart';
import '../../tools/res_color.dart';
import '../viewmodel/sell_viewmodel.dart';
import '../widget/buyer_shimmer.dart';
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
        title: const Text(
          "Ma'lumotlarini kiriting",
          style: TextStyle(color: ResColors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  TextFormField(
                    controller: viewModel.buyerController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      border: const OutlineInputBorder(),
                      hintText: "Xaridorni tanlang",
                      label: const Text("Xaridor"),
                      suffixIcon: IconButton(
                        onPressed: () {
                          viewModel.buyerController.text = "";
                          viewModel.selectedBuyer = null;
                          viewModel.searchBuyers(null);
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    focusNode: viewModel.focusNode,
                    onChanged: (value) {
                      viewModel.searchBuyers(value);
                    },
                  ),
                  Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: viewModel.priceC,
                            maxLength: 15,
                            inputFormatters: [CurrencyInputFormatter()],
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              counterText: "",
                              filled: true,
                              fillColor: ResColors.textFieldBg,
                              border: const OutlineInputBorder(),
                              hintText: "100 000 000",
                              suffixText: "so'm",
                              label: Text("Avtomobil bahosi"),
                            ),
                            style: const TextStyle(
                              color: ResColors.black,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: viewModel.compensationC,
                            maxLength: 15,
                            keyboardType: TextInputType.number,
                            inputFormatters: [CurrencyInputFormatter()],
                            decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              fillColor: ResColors.textFieldBg,
                              border: const OutlineInputBorder(),
                              hintText: "100 000 000",
                              suffixText: "so'm",
                              label: const Text("Kompensatsiya puli"),
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
                                  hint: Text(
                                    "To'lov turini tanlang",
                                  ),
                                  items: viewModel.paymentTypes
                                      .map((item) => DropdownMenuItem(
                                            value: item,
                                            child: Text(
                                              item,
                                              style:
                                                  const TextStyle(fontSize: 20),
                                            ),
                                          ))
                                      .toList(),
                                  onChanged: (value) {
                                    viewModel
                                        .changePaymentType(value ?? "cash");
                                  },
                                )
                              : Container(),
                          viewModel.paymentType == viewModel.paymentTypes[1]
                              ? Column(
                                  children: [
                                    const SizedBox(height: 16),
                                    Text(
                                      "Kredit ma'lumotlari",
                                      style: const TextStyle(
                                        color: ResColors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      controller: viewModel.prePriceC,
                                      maxLength: 15,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        CurrencyInputFormatter()
                                      ],
                                      decoration: InputDecoration(
                                        counterText: "",
                                        filled: true,
                                        fillColor: ResColors.textFieldBg,
                                        border: const OutlineInputBorder(),
                                        hintText: "100 000 000",
                                        suffixText: "so'm",
                                        label: Text("Oldindan to'lov"),
                                      ),
                                      style: const TextStyle(
                                        color: ResColors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      controller: viewModel.pricePerMC,
                                      maxLength: 15,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        CurrencyInputFormatter()
                                      ],
                                      decoration: InputDecoration(
                                        counterText: "",
                                        filled: true,
                                        fillColor: ResColors.textFieldBg,
                                        border: const OutlineInputBorder(),
                                        hintText: "100 000 000",
                                        suffixText: "so'm",
                                        label: Text("Oylik to'lov"),
                                      ),
                                      style: const TextStyle(
                                        color: ResColors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      controller: viewModel.periodC,
                                      maxLength: 4,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        filled: true,
                                        fillColor: ResColors.textFieldBg,
                                        border: const OutlineInputBorder(),
                                        hintText: "48",
                                        suffixText: "oy",
                                        label: Text("Kredit muddati"),
                                      ),
                                      style: const TextStyle(
                                        color: ResColors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                )
                              : Container(),
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
                                  goHomePage(context);
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
                        ],
                      ),
                      viewModel.isNoBuyer
                          ? Container(
                              width: MediaQuery.sizeOf(context).width,
                              margin: const EdgeInsets.only(top: 10),
                              decoration: const BoxDecoration(
                                  color: ResColors.textFieldBg,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              height: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Xaridor topilmadi!",
                                    style: TextStyle(
                                        color: ResColors.black,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Iltimos, xaridorni qo'shish uchun tugmani bosing",
                                    style: TextStyle(
                                        color: ResColors.black, fontSize: 14),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width - 100,
                                    height: 50,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: ResColors.mainBg,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () {
                                        _addBuyer(context, viewModel);
                                      },
                                      child: Text(
                                        "Xaridor qo'shish",
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: ResColors.black,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : viewModel.isFocused
                              ? Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  margin: const EdgeInsets.only(top: 10),
                                  decoration: const BoxDecoration(
                                    color: ResColors.textFieldBg,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                  ),
                                  height: 200,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: viewModel.isLoading
                                        ? const BuyerShimmer()
                                        : ListView.builder(
                                            itemCount: viewModel.buyers.length,
                                            itemBuilder: (context, position) =>
                                                GestureDetector(
                                              onTap: () {
                                                viewModel.selectBuyer(position);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "${viewModel.buyers[position].firstName} ${viewModel.buyers[position].lastName} ${viewModel.buyers[position].middleName}",
                                                  style: const TextStyle(
                                                      color: ResColors.black),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ),
                                )
                              : Container(),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future _addBuyer(BuildContext context, SellViewModel viewModel) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      barrierColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: SizedBox(
              width: MediaQuery.sizeOf(context).width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Xaridor haqida ma'lumot",
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
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      border: const OutlineInputBorder(),
                      hintText: "Palankas",
                      label: Text("Ism"),
                    ),
                    style: const TextStyle(
                      color: ResColors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: viewModel.buyerLastName,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      border: const OutlineInputBorder(),
                      hintText: "Palankasov",
                      label: Text("Familiya"),
                    ),
                    style: const TextStyle(
                      color: ResColors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: viewModel.buyerMiddleName,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      border: const OutlineInputBorder(),
                      hintText: "Palankas o'g'li",
                      label: Text("Otasining ismi"),
                    ),
                    style: const TextStyle(
                      color: ResColors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: viewModel.buyerBirthday,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      border: const OutlineInputBorder(),
                      hintText: "12-04-2004",
                      label: Text("Tugilgan sana"),
                    ),
                    style: const TextStyle(
                      color: ResColors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: viewModel.buyerPassport,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      border: const OutlineInputBorder(),
                      hintText: "AA1234567",
                      label: Text("Passport"),
                    ),
                    style: const TextStyle(
                      color: ResColors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextFormField(
                    controller: viewModel.buyerAddress,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      border: const OutlineInputBorder(),
                      hintText: "Karvak qishlog'i",
                      label: Text("Manzil"),
                    ),
                    style: const TextStyle(
                      color: ResColors.black,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: viewModel.buyerPhoneNumber,
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      hintText: "901234567",
                      counterText: "",
                      labelText: "Telefon nomer",
                      border: OutlineInputBorder(),
                      prefix: Text(
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
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      hintText: "901234567",
                      counterText: "",
                      labelText: "Qo'shimcha telefon",
                      border: OutlineInputBorder(),
                      prefix: Text(
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

                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width,
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ResColors.textFieldBg,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "cancel".tr(),
                              style: const TextStyle(
                                color: ResColors.black,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: SizedBox(
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
                              viewModel.addBuyer(() {
                                Navigator.pop(context);
                              });
                            },
                            child: Text(
                              "add".tr(),
                              style: const TextStyle(
                                color: ResColors.white,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
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
