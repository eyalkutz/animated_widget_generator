
import 'package:source_gen/source_gen.dart';

import 'animated_widget_generator.dart';
import 'package:build/build.dart';
// Builder animatedWidgetBuilder(BuildOptions options)=>AnimatedWidgetBuilder();
Builder animatedWidgetBuilder(BuilderOptions options) =>
    SharedPartBuilder([AnimatedWidgetGenerator()], 'animate');