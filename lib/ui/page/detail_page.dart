import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:qas/fake/fakes.dart';
import 'package:qas/tools/res_color.dart';
import 'package:qas/tools/utils.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  CarouselController carouselController = CarouselController();
  final car = cars[0];
  int caruselIndex = 0;
  final images = [
    "https://centralasia-adventures.com/image/new/legkovaya-mashina-shevrole-kobalt-2-g.jpg",
    "https://storage.kun.uz/source/6/2HX_jF3Lbu8YoOfbjw6zZvEwM4Sd1mHN.jpg",
    "https://img03.platesmania.com/170820/o/10279365.jpg",
    "https://img03.platesmania.com/170820/o/10279365.jpg",
    "https://img03.platesmania.com/170820/o/10279365.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ResColors.mainBg,
      appBar: AppBar(
        backgroundColor: ResColors.mainBg,
        title: Text(
          car.name,
          style: const TextStyle(color: ResColors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CarouselSlider(
              carouselController: carouselController,
              items: images.map((image) {
                return Image.network(
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  image,
                  fit: BoxFit.cover,
                  width: MediaQuery.sizeOf(context).width,
                  height: 290,
                );
              }).toList(),
              options: CarouselOptions(
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  caruselIndex = index;
                  setState(() {});
                },
                enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 6, left: 10, right: 10),
              height: 4,
              width: images.length * 60,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: images.length,
                itemBuilder: (context, position) => GestureDetector(
                  onTap: () {
                    caruselIndex = position;
                    carouselController.animateToPage(position);
                    setState(() {});
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 6),
                    width: 45,
                    height: 4,
                    color: itemColor(position),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    "${142000000.0.price()}",
                    style: const TextStyle(
                      fontSize: 36,
                      color: ResColors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "Xarakteristika",
                    style: TextStyle(
                        color: ResColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Ishlab chiqarilgan yili: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        cars[0].year,
                        style: const TextStyle(
                            color: ResColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Ishlab chiqarilgan yili: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        cars[0].year,
                        style: const TextStyle(
                            color: ResColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Ishlab chiqarilgan yili: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        cars[0].year,
                        style: const TextStyle(
                            color: ResColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Ishlab chiqarilgan yili: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        cars[0].year,
                        style: const TextStyle(
                            color: ResColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Ishlab chiqarilgan yili: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        cars[0].year,
                        style: const TextStyle(
                            color: ResColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Ishlab chiqarilgan yili: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        cars[0].year,
                        style: const TextStyle(
                            color: ResColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Ishlab chiqarilgan yili: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        cars[0].year,
                        style: const TextStyle(
                            color: ResColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Ishlab chiqarilgan yili: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        cars[0].year,
                        style: const TextStyle(
                            color: ResColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Ishlab chiqarilgan yili: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        cars[0].year,
                        style: const TextStyle(
                            color: ResColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Ishlab chiqarilgan yili: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        cars[0].year,
                        style: const TextStyle(
                            color: ResColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Ishlab chiqarilgan yili: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        cars[0].year,
                        style: const TextStyle(
                            color: ResColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "Avtomobil haqida",
                    style: TextStyle(
                        color: ResColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "sdkfh kjsdh fjkdshkjsdhfkjds hfjksdh jkf sdjkfhjk dshfjksh jkhsdjkfh sdjkh fjksdh fsdhiufhius dh f9rehfiueryfiouerhiudhfjksdhf8eorh foefvioue e78hf oerfg oiefh 78oefoier hfekr foer7yf 89erhg iuerfg89p eryg p98erg 98peg9erhg oehgke8yu 8er gofhg oiuehg 9erh gopuieh gjkeg9ueh 9ghe g",
                    style: TextStyle(
                      color: ResColors.black,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    "O’xshash avtomobillar",
                    style: TextStyle(
                        color: ResColors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 180,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, position) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        color: Colors.red,
                        height: 180,
                        width: 170,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      floatingActionButton:  SizedBox(
        width: MediaQuery.sizeOf(context).width-24,
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
            "Sotish",
            style: const TextStyle(
              color: ResColors.white,
              fontSize: 18,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Color itemColor(i) {
    return caruselIndex == i ? ResColors.mainColor : ResColors.greyYellow;
  }
}
