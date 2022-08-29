import 'dart:async';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ScrollToHideWidget extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;
  late Function callback;
  final Stream<bool> stream;

  ScrollToHideWidget(
      {Key? key,
      required this.child,
      required this.controller,
      this.duration = const Duration(milliseconds: 200),
      required this.stream})
      : super(key: key);

  @override
  State<ScrollToHideWidget> createState() => _ScrollToHideWidgetState();
}

class _ScrollToHideWidgetState extends State<ScrollToHideWidget> {
  bool isVisible = true;

  void mySetState(bool boolean) {
    if (!isVisible) {
      setState(() => isVisible = true);
    } else if (isVisible) {
      setState(() => isVisible = false);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(listen);
    widget.stream.listen((boolean) {
      mySetState(boolean);
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(listen);
    super.dispose();
  }

  void listen() async {
    final direction = widget.controller.position.userScrollDirection;
    if (direction == ScrollDirection.forward) {
      show();
    } else if (direction == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if (!isVisible) setState(() => isVisible = true);
  }

  void hide() {
    if (isVisible) setState(() => isVisible = false);
  }

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: widget.duration,
        height: isVisible ? kBottomNavigationBarHeight : 0,
        child: Wrap(children: [widget.child]),
      );
}
