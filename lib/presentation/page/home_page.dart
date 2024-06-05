import 'package:flutter/material.dart';

import '../../fake/fakes.dart';
import '../../tools/res_color.dart';
import '../widget/car_item.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _rusumi = TextEditingController();
  final TextEditingController _startYear = TextEditingController();
  final TextEditingController _finishYear = TextEditingController();
  final TextEditingController _startMoney = TextEditingController();
  final TextEditingController _finishMoney = TextEditingController();
  DateTime selectedDate = DateTime(2024);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ResColors.mainBg,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: AppBar(
          backgroundColor: ResColors.mainColor,
          leading: Image.asset('assets/images/ic_logo.png'),
          leadingWidth: 90,
          actions: [
            GestureDetector(
              onTap: () {
                //open scanner
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: ResColors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Icon(
                  Icons.qr_code_scanner,
                  color: ResColors.black,
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: () {
                _searchSheet();
              },
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: ResColors.white,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: const Icon(
                  Icons.search,
                  color: ResColors.black,
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
          itemCount: cars.length,
          itemBuilder: (context, position) => CarItem(
            car: cars[position],
            onItemClick: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const DetailPage()),
              );
            },
          ),
        ),
      ),
    );
  }

  Future _searchSheet() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      barrierColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: 470,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Qidiruv",
                style: const TextStyle(
                  color: ResColors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 18),
              Text(
                "Rusumi",
                style: const TextStyle(
                  fontSize: 14,
                  color: ResColors.black,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                width: MediaQuery.sizeOf(context).width - 32,
                decoration: const BoxDecoration(
                  color: ResColors.textFieldBg,
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                child: DropdownButtonFormField(
                  dropdownColor: ResColors.textFieldBg,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                  ),
                  hint: Text(
                    "Tanlang",
                    style: const TextStyle(color: ResColors.black),
                  ),
                  items: rusums
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      _rusumi.text = value ?? "";
                    });
                  },
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Ishlab chiqarilgan yili",
                style: TextStyle(
                  color: ResColors.black,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 56,
                      decoration: const BoxDecoration(
                          color: ResColors.textFieldBg,
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: TextField(
                        controller: _startYear,
                        readOnly: true,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.calendar_month),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          hintText: "Yildan",
                          hintStyle: TextStyle(
                            color: ResColors.black,
                          ),
                        ),
                        onTap: () {
                          _selectYear().then((value) => {
                                setState(() {
                                  _startYear.text = value.toString();
                                })
                              });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: ResColors.textFieldBg,
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: TextField(
                        controller: _finishYear,
                        readOnly: true,
                        decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.calendar_month),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          hintText: "Yilgacha",
                          hintStyle: TextStyle(color: ResColors.black),
                        ),
                        onTap: () {
                          _selectYear().then((value) => {
                                setState(() {
                                  _finishYear.text = value.toString();
                                })
                              });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Narxi",
                style: TextStyle(
                  fontSize: 14,
                  color: ResColors.black,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: ResColors.textFieldBg,
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: TextField(
                        maxLength: 4,
                        controller: _startMoney,
                        //controller: _startYear,
                        //readOnly: true,
                        decoration: const InputDecoration(
                          suffixText: "mln",
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          hintText: "10",
                          hintStyle: TextStyle(
                            color: ResColors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: ResColors.textFieldBg,
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      child: TextField(
                        controller: _finishMoney,
                        readOnly: true,
                        maxLength: 4,
                        decoration: const InputDecoration(
                          suffixText: "mln",
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          hintText: "100",
                          hintStyle: TextStyle(color: ResColors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
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
                        child: const Text(
                          "Bekor qilish",
                          style: TextStyle(
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
                        onPressed: () {},
                        child: const Text(
                          "Qidirish",
                          style: TextStyle(
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
    );
  }

  Future<int> _selectYear() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Yilni tanlnag",
            style: TextStyle(
              color: ResColors.black,
            ),
          ),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 30, 1),
              lastDate: DateTime(DateTime.now().year, 1),
              selectedDate: selectedDate,
              onChanged: (DateTime dateTime) {
                selectedDate = dateTime;
                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
    return selectedDate.year;
  }
}
