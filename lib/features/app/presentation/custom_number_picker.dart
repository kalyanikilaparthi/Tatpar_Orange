import 'package:flutter/material.dart';
import 'package:tatpar_orange/configurations/theme/size_constants.dart';

class CustomNumberPicker extends StatefulWidget {
  final List<int> items;
  final Function(int) callback;
  final double? height, fontSize;
  final int initialItemIndex;

  const CustomNumberPicker({
    super.key,
    required this.items,
    required this.callback,
    required this.initialItemIndex,
    this.height,
    this.fontSize,
  });

  @override
  State<CustomNumberPicker> createState() => _CustomNumberPickerState();
}

class _CustomNumberPickerState extends State<CustomNumberPicker> {
  late FixedExtentScrollController _scrollController;
  late int curIndex;

  @override
  void initState() {
    super.initState();
    setScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void setScrollController() {
    curIndex = widget.initialItemIndex;
    _scrollController =
        FixedExtentScrollController(initialItem: widget.initialItemIndex);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(kPadding),
      height: widget.height ?? kPadding * 12,
      alignment: Alignment.center,
      color: Colors.transparent,
      child: RotatedBox(
        quarterTurns: 3,
        child: ListWheelScrollView(
          controller: _scrollController,
          itemExtent: kPadding * 12,
          onSelectedItemChanged: (item) {
            widget.callback(item);
            setState(() {
              curIndex = item;
            });
          },
          children: widget.items
              .map(
                (element) => DecoratedBox(
                  decoration: BoxDecoration(
                    color: element == widget.items[curIndex]
                        ? theme.primaryColor
                        : theme.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(kPadding * 2.5),
                  ),
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Center(
                      child: Text(
                        element.toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: theme.colorScheme.onPrimary,
                          fontSize: widget.fontSize ?? kPadding * 4,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
