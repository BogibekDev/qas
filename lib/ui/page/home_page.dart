import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qas/ui/widget/dialogs.dart';

import '../../tools/res_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ResColors.mainBg,
      body: Column(
        children: [
          Container(
            height: 160,
            padding: const EdgeInsets.only(bottom: 18, left: 16, right: 16),
            color: ResColors.mainColor,
            child:  Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Image(
                  image: AssetImage("assets/images/img.png"),
                  width: 90,
                  height: 60,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: (){
                        //show bottomsheet
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: ResColors.white,
                          borderRadius: BorderRadius.circular(8.0)
                        ),
                        child: const Icon(Icons.search),
                      ),
                    )
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
