import 'package:fitness/core/widgets/custom_shimmer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class CustomListViewShimmer extends StatelessWidget {
  const CustomListViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        separatorBuilder: (_, __) => 12.verticalSpace,
        itemBuilder: (_, __) => CustomShimmerItem(),
      ),
    );
  }
}
