import 'package:flutter/material.dart';
import 'package:qas/tools/res_color.dart';

import '../../domain/entities/sell/buyer.dart';

class SellPage extends StatefulWidget {
  const SellPage({super.key, required this.carId});

  final int carId;

  @override
  State<SellPage> createState() => _SellPageState();
}

class _SellPageState extends State<SellPage> {
  List<Buyer> buyers = [
    Buyer(1, "John", "Doe", "A", "1985", "P1234567",
        "123 Elm St, Springfield, IL", "555-1234", "555-5678"),
    Buyer(2, "Jane", "Smith", "B", "1990", "P7654321",
        "456 Oak St, Springfield, IL", "555-8765", "555-4321"),
    Buyer(3, "Emily", "Johnson", "C", "1975", "P2345678",
        "789 Pine St, Springfield, IL", "555-2345", "555-6789"),
    Buyer(4, "Michael", "Williams", "D", "1982", "P8765432",
        "101 Maple St, Springfield, IL", "555-3456", "555-9876"),
    Buyer(5, "Sarah", "Brown", "E", "1995", "P3456789",
        "202 Birch St, Springfield, IL", "555-4567", "555-7890"),
    Buyer(6, "David", "Jones", "F", "1988", "P9876543",
        "303 Cedar St, Springfield, IL", "555-5678", "555-8901"),
    Buyer(7, "Laura", "Garcia", "G", "1992", "P4567890",
        "404 Walnut St, Springfield, IL", "555-6789", "555-9012"),
    Buyer(8, "Daniel", "Martinez", "H", "1980", "P0987654",
        "505 Chestnut St, Springfield, IL", "555-7890", "555-0123"),
    Buyer(9, "Lisa", "Hernandez", "I", "1987", "P5678901",
        "606 Poplar St, Springfield, IL", "555-8901", "555-1234"),
    Buyer(10, "James", "Lopez", "J", "1993", "P1098765",
        "707 Ash St, Springfield, IL", "555-9012", "555-2345"),
  ];
  Buyer? selectedBuyer;
  final TextEditingController buyerController = TextEditingController();
  final TextEditingController compensationC = TextEditingController();
  final TextEditingController prePriceC = TextEditingController();
  final TextEditingController periodC = TextEditingController();
  final TextEditingController remainingPriceC = TextEditingController();
  final TextEditingController priceC = TextEditingController();

  FocusNode focusNode = FocusNode();
  bool isFocused = false;
  bool isNoBuyer = false;
  List<String> paymentTypes = ["cash", "credit"];
  String paymentType = "";

  @override
  void initState() {
    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    controller: buyerController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: ResColors.textFieldBg,
                      border: const OutlineInputBorder(),
                      hintText: "Xaridorni tanlang",
                      label: const Text("Xaridor"),
                      suffixIcon: IconButton(
                        onPressed: () {
                          buyerController.text = "";
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    focusNode: focusNode,
                    onChanged: (value) {},
                  ),
                  Stack(
                    children: [
                      Column(
                        children: [
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: priceC,
                            maxLength: 15,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              counterText: "",
                              filled: true,
                              fillColor: ResColors.textFieldBg,
                              border: const OutlineInputBorder(),
                              hintText: "Umumiy summa : ",
                              label: const Text("Umumiy summa"),
                            ),
                            style: const TextStyle(
                              color: ResColors.black,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: compensationC,
                            maxLength: 15,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              fillColor: ResColors.textFieldBg,
                              border: const OutlineInputBorder(),
                              hintText: "Kompensatsiya puli : ",
                              label: const Text("Kompensatsiya puli"),
                            ),
                            style: const TextStyle(
                              color: ResColors.black,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 16),
                          paymentTypes.isNotEmpty
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
                                  items: paymentTypes
                                      .map((e) => DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e,
                                            style: TextStyle(fontSize: 20),
                                          )))
                                      .toList(),
                                  onChanged: (value) {
                                    paymentType = value ?? "";
                                    setState(() {});
                                  },
                                )
                              : Container(),
                          paymentType == paymentTypes[1]
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
                                      controller: prePriceC,
                                      maxLength: 15,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        filled: true,
                                        fillColor: ResColors.textFieldBg,
                                        border: const OutlineInputBorder(),
                                        hintText: "100 000 000",
                                        label: Text("Oldindan to'lov"),
                                      ),
                                      style: const TextStyle(
                                        color: ResColors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      controller: remainingPriceC,
                                      maxLength: 15,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        filled: true,
                                        fillColor: ResColors.textFieldBg,
                                        border: const OutlineInputBorder(),
                                        hintText: "100 000 000",
                                        label: Text("Qoldiq summa"),
                                      ),
                                      style: const TextStyle(
                                        color: ResColors.black,
                                        fontSize: 20,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      controller: periodC,
                                      maxLength: 4,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        counterText: "",
                                        filled: true,
                                        fillColor: ResColors.textFieldBg,
                                        border: const OutlineInputBorder(),
                                        hintText: "48",
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
                          SizedBox(height: 16),
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
                              onPressed: () {},
                              child: Text(
                                "Sotish",
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
                      isFocused
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
                                child: ListView.builder(
                                  itemCount: buyers.length,
                                  itemBuilder: (context, position) =>
                                      GestureDetector(
                                    onTap: () {
                                      selectedBuyer = buyers[position];
                                      buyerController.text =
                                          "${buyers[position].firstName} ${buyers[position].lastName}";
                                      focusNode.unfocus();
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        "${buyers[position].firstName} ${buyers[position].lastName}",
                                        style: const TextStyle(
                                            color: ResColors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : isNoBuyer
                              ? Container(
                                  width: MediaQuery.sizeOf(context).width,
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: const BoxDecoration(
                                      color: ResColors.textFieldBg,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  height: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                            color: ResColors.black,
                                            fontSize: 14),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.sizeOf(context).width -
                                                100,
                                        height: 50,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: ResColors.mainBg,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          onPressed: () {},
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
}
