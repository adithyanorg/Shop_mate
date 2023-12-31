// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shop_mate/presentation/constants/colors.dart';
import 'package:shop_mate/presentation/widgets/text_widgets.dart';

class BuildProductCard extends StatelessWidget {
  BuildProductCard({
    Key? key,
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    this.onTap,
  }) : super(key: key);

  final Image image;
  final String title;
  final String price;
  final String description;
  Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap!();
      },
      child: Card(
        elevation: 2,
        child: Container(
          width: 165.sp,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: image,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        "\$$price",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 130,
                            height: 50.sp,
                            child: Text(
                              description,
                              style: TextStyle(
                                fontSize: 11.sp,
                                overflow: TextOverflow.clip,
                                color: AppColor.colorGrey1,
                              ),
                            ),
                          ),
                          Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                              color: AppColor.greenColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add,
                                color: AppColor.whiteColor,
                                size: 18,
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
