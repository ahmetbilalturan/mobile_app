import 'dart:async';

import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ScrollToHideWidget extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;
  bool isVisible = true;
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
  void mySetState(bool boolean) {
    /*  setState(() {
      widget.isVisible = boolean;
    }); */
    if (!(widget.isVisible)) {
      setState(() => widget.isVisible = true);
    } else if (widget.isVisible) {
      setState(() => widget.isVisible = false);
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
    if (!(widget.isVisible)) setState(() => widget.isVisible = true);
  }

  void hide() {
    if (widget.isVisible) setState(() => widget.isVisible = false);
  }

  @override
  Widget build(BuildContext context) => AnimatedContainer(
        duration: widget.duration,
        height: widget.isVisible ? kBottomNavigationBarHeight : 0,
        child: Wrap(children: [widget.child]),
      );
}
