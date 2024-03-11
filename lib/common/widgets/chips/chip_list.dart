import 'package:flutter/material.dart';
import 'package:onlinebozor/common/widgets/chips/chip_add_item.dart';
import 'package:onlinebozor/common/widgets/chips/chip_show_less_item.dart';
import 'package:onlinebozor/common/widgets/chips/chip_show_more_item.dart';

class ChipList extends StatelessWidget {
  const ChipList({
    super.key,
    required this.chips,
    required this.isShowAll,
    required this.onClickedAdd,
    required this.onClickedShowLess,
    required this.onClickedShowMore,
    this.minCount = 3,
  });

  final List<Widget> chips;
  final Function() onClickedAdd;
  final Function() onClickedShowLess;
  final Function() onClickedShowMore;
  final bool isShowAll;
  final int minCount;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.start,
      crossAxisAlignment: WrapCrossAlignment.start,
      runAlignment: WrapAlignment.start,
      children: _getActualChips(),
    );
  }

  List<Widget> _getActualChips() {
    List<Widget> actualChips = [];
    actualChips.add(ChipAddItem(onClicked: onClickedAdd));
    if (chips.length <= minCount) {
      actualChips.addAll(chips);
      return actualChips;
    } else {
      if (isShowAll) {
        actualChips.addAll(chips);
        actualChips.add(ChipShowLessItem(onClicked: onClickedShowLess));
      } else {
        actualChips.addAll(chips.sublist(0, minCount));
        actualChips.add(ChipShowMoreItem(onClicked: onClickedShowMore));
      }
      return actualChips;
    }
  }
}