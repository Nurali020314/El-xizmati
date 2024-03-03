
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HorizontalAddListShimmer extends StatelessWidget {
  const HorizontalAddListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 342,
      width: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: 165,
              height: 160,
              decoration: BoxDecoration(color: Color(0xFFF6F7FC)),
              child: Stack(children: [
                Shimmer.fromColors(
                  baseColor: Color(0xFFE8E6E8),
                  highlightColor: Colors.grey[50]!,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                ),

              ])),
          SizedBox(height: 12),
          Shimmer.fromColors(
            baseColor: Color(0xFFE8E6E8),
            highlightColor: Colors.grey[50]!,
            child: Container(
              height: 15,
              width: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
          SizedBox(height: 20),
          Shimmer.fromColors(
            baseColor: Color(0xFFE8E6E8),
            highlightColor: Colors.grey[50]!,
            child: Container(
              margin: EdgeInsets.only(right:28),
              height: 12,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            Expanded(
              child: Shimmer.fromColors(
                baseColor: Color(0xFFE8E6E8),
                highlightColor: Colors.grey[50]!,
                child: Container(
                  margin: EdgeInsets.only(right: 58),
                  height: 12,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            )
          ]),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Shimmer.fromColors(
                baseColor: Color(0xFFE8E6E8),
                highlightColor: Colors.grey[50]!,
                child: Container(
                  height: 22,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Shimmer.fromColors(
                baseColor: Color(0xFFE8E6E8),
                highlightColor: Colors.grey[50]!,
                child: Container(
                  height: 22,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

}