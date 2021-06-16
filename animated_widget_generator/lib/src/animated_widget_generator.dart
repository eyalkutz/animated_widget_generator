import 'package:build/build.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:animated_widget_annotations/animated_widget_annotations.dart';

const animatableFieldChecker = TypeChecker.fromRuntime(AnimatableField);

class _Field {
  String type;
  String name;
  _Field(this.type, this.name);
}

class AnimatedWidgetGenerator extends GeneratorForAnnotation<AnimatableWidget> {
  /// determines if [field] should be animated
  ///
  /// [field] should be animated if it is annotated with [AnimatableField]
  bool shouldAnimate(FieldElement field) {
    return animatableFieldChecker.firstAnnotationOfExact(field) != null;
  }

  @override
  generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    final _class = element as ClassElement;
    final className = _class.displayName;
    final fields =
        _class.fields.where((field) => field.displayName != 'hashCode');
    final buffer = StringBuffer();
    // shorthand for the function because I will use it a lot
    final w = buffer.writeln;
    final newClassName = '${className}Transition';
    w('class $newClassName extends AnimatedWidget{');
    final newFields = fields.map((field) {
      final type = field.type.getDisplayString(withNullability: false);
      final name = field.displayName;
      if (shouldAnimate(field))
        return _Field('Animation<$type>', name);
      else
        return _Field(type, name);
    }).toList();
    writeFields(w, newFields);

    writeConstructor(w, newFields, newClassName);

    writeBuild(w, newFields, className);
    w('}');
    return buffer.toString();
  }

  void writeFields(void w(Object obj), List<_Field> newFields) {
    for (var field in newFields) w('final ${field.type} ${field.name};');
  }

  void writeBuild(void w(Object obj), List<_Field> fields, String className) {
    w('@override');
    w('build(BuildContext context){');
    final widgetArgumentList = fields.map((field) {
      final fieldParameter = '${field.name}:${field.name}';
      if (field.type.startsWith('Animation'))
        return '$fieldParameter.value';
      else
        return fieldParameter;
    }).join(',');
    w('return $className($widgetArgumentList,);');
    w('}');
  }

  void writeConstructor(
      void w(Object obj), List<_Field> fields, String className) {
    final constructorArgumentList =
        fields.map((field) => 'required this.${field.name}').join(',');
    final listanableArgumentList = fields
        .where((field) => field.type.startsWith('Animation'))
        .map((field) => field.name)
        .join(',');
    w('$className({$constructorArgumentList,}):super(listenable:Listenable.merge([$listanableArgumentList,]));');
  }
}
