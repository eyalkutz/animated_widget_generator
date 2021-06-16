// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example_widget.dart';

// **************************************************************************
// AnimatedWidgetGenerator
// **************************************************************************

class FooTransition extends AnimatedWidget {
  final Animation<Size> size;
  final Animation<Color> color;
  final String text;
  FooTransition({
    required this.size,
    required this.color,
    required this.text,
  }) : super(
            listenable: Listenable.merge([
          size,
          color,
        ]));
  @override
  build(BuildContext context) {
    return Foo(
      size: size.value,
      color: color.value,
      text: text,
    );
  }
}
