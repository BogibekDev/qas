import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../fake/fakes.dart';
import '../../tools/res_color.dart';
import '../../tools/utils.dart';
import '../widget/similar_item.dart';

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
    "https://qas.chogirmali.uz/media/1_Снимок экрана 2023--28 в 14.46.37.png",
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
                return CachedNetworkImage(
                  imageUrl: image,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error_outline,
                    size: 100,
                  ),
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
                      fontSize: 32,
                      color: ResColors.black,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: MediaQuery.sizeOf(context).width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                        color: ResColors.textFieldBg,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Muddatli to'lov",
                            style: TextStyle(
                              color: ResColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Oldindan to'lov",
                                    style: TextStyle(
                                      color: ResColors.black,
                                    ),
                                  ),
                                  Text(
                                    "~ \$4311",
                                    style: TextStyle(
                                      color: ResColors.black,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Oyma-oy to'lov",
                                    style: TextStyle(
                                      color: ResColors.black,
                                    ),
                                  ),
                                  Text(
                                    "12 x ~ \$4311",
                                    style: TextStyle(
                                      color: ResColors.black,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Filial: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(width: 30),
                      Text(
                        "1-filial",
                        style: const TextStyle(
                            color: ResColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(height: 16),
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
                        "Model: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        cars[0].name,
                        style: const TextStyle(
                            color: ResColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Rangi: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Kulrang",
                        style: const TextStyle(
                            color: ResColors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Yoqilg'i turi: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Gaz(Metan)",
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
                        "Uzatma qutisi: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Auto",
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
                        "Bosib o'tgan masofasi: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        cars[0].mileage,
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
                        "Kraskasi: ",
                        style: TextStyle(
                          color: ResColors.black,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Kraskasi toza",
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
                      itemBuilder: (context, position) => SimilarItem(
                        car: car,
                        onItemClick: () {},
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
      floatingActionButton: SizedBox(
        width: MediaQuery.sizeOf(context).width - 24,
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
