import 'package:flutter/material.dart';
import 'package:animated_widget_generator/animated_widget_generator.dart';
import 'package:animated_widget_annotations/animated_widget_annotations.dart';

part 'example_widget.g.dart';

@AnimatableWidget()
class Foo extends StatelessWidget {
  @AnimatableField(tweenType: SizeTween)
  final Size size;
  @AnimatableField(tweenType: ColorTween)
  final Color color;
  final String text;
  const Foo({
    Key? key,
    required this.size,
    required this.color,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      color: color,
      child: Text(text),
    );
  }
}
