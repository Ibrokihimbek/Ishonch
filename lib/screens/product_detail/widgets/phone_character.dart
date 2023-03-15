import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ishonch/data/models/model_category/categories/product/product_model.dart';

class PhoneCharacter extends StatelessWidget {
  final ProductModel product;

  const PhoneCharacter({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        infoMethod(
          fieldName: "rang:".tr(),
          product: product.phone.color,
          context: context,
        ),
        SizedBox(height: 5.h),
        infoMethod(
          fieldName: 'ekran:'.tr(),
          product: product.phone.display,
          context: context,
        ),
        SizedBox(height: 5.h),
        infoMethod(
          fieldName: 'xotira_RAM:'.tr(),
          product: product.phone.memoryRam,
          context: context,
        ),
        SizedBox(height: 5.h),
        infoMethod(
          fieldName: 'xotira_ROM:'.tr(),
          product: product.phone.memoryRom,
          context: context,
        ),
        SizedBox(height: 5.h),
        infoMethod(
          fieldName: 'kafolat:'.tr(),
          product: product.phone.warranty,
          context: context,
        ),
        SizedBox(height: 5.h),
        infoMethod(
          fieldName: 'grafik_karta:'.tr(),
          product: product.phone.videoCard,
          context: context,
        ),
      ],
    );
  }

  Widget infoMethod(
      {required String fieldName,
      required String product,
      required BuildContext context}) {
    return SizedBox(
      height: 40.h,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).cardColor),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w).r,
              child: Center(
                child: Text(
                  fieldName,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        fontSize: 15.sp,
                      ),
                ),
              ),
            ),
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).cardColor),
              ),
              padding: EdgeInsets.symmetric(horizontal: 12.w).r,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: product.substring(
                          0,
                          product.length > 25 ? 25 : product.length,
                        ),
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontSize: 15.sp,
                                ),
                      ),
                      TextSpan(
                        text: product.length > 25 ? "..." : "",
                        style: const TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
