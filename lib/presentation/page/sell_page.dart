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
  FocusNode focusNode = FocusNode();
  bool isFocused = false;

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
      body: Column(
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
                    hintText: "Haridorni tanlang",
                    label: const Text("Haridor"),
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
                        TextFormField(),
                        TextFormField(),
                        TextFormField(),
                        TextFormField(),
                        TextFormField(),
                        TextFormField(),
                      ],
                    ),
                    isFocused
                        ? Container(
                      width: MediaQuery.sizeOf(context).width,
                      decoration: const BoxDecoration(
                          color: ResColors.textFieldBg,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          )),
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          itemCount: buyers.length,
                          itemBuilder: (context, position) => GestureDetector(
                            onTap: () {
                              focusNode.unfocus();
                              buyerController.text =
                              "${buyers[position].firstName} ${buyers[position].lastName}";
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${buyers[position].firstName} ${buyers[position].lastName}",
                                style:
                                const TextStyle(color: ResColors.black),
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
    );
  }
}
