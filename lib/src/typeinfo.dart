part of json_conv;

final _mirList = reflectType(List);
final _mirMap = reflectType(Map);
final _emptySymbol = new Symbol("");

bool _isPrimitive(Type value) {
  return value == num ||
      value == bool ||
      value == String ||
      value == null ||
      value == Null ||
      value == int ||
      value == double;
}

enum _CmplxType { MAP, LIST, OBJECT, PRIMITIVE, TYPESEEKER }

class _Element {
  Symbol symbol;
  Type type;
  _CmplxType ctype;
  Map<String, _Element> children;
  TypeSeeker typeSeeker;
  Implementation impl;
  Property prop;
  ClassMirror cm;

  _Element();

  _Element.withSymbol(this.symbol, {this.type, this.ctype});

  bool get ignore => (prop != null) ? prop.ignore : false;

  @override
  String toString() {
    return "_Element<$type> symbol: $symbol, ctype: $ctype";
  }
}

final _cache = <Type, _Element>{};

_Element _generateElements(Type type, {bool isChild: false}) {
  if (type == dynamic) throw new StateError("type cant be dynamic");
  if (_cache.containsKey(type) && !isChild) {
    return _cache[type];
  }

  final classMirror = reflectClass(type);
  final typeMirror = reflectType(type);
  final ele = new _Element.withSymbol(classMirror.simpleName);

  ele.cm = classMirror;

  ele.prop = getAnnotation(classMirror.metadata, Property) as Property;
  ele.typeSeeker =
      getAnnotation(classMirror.metadata, TypeSeeker) as TypeSeeker;
  ele.impl =
      getAnnotation(classMirror.metadata, Implementation) as Implementation;
  ele.type = type;

  if (_isPrimitive(type)) {
    ele.ctype = _CmplxType.PRIMITIVE;
    return ele;
  }

  _CmplxType ctype = _CmplxType.LIST;
  int index = 0;
  if (typeMirror.isAssignableTo(_mirMap)) {
    index = 1;
    ctype = _CmplxType.MAP;
  }
  if (typeMirror.isAssignableTo(_mirMap) ||
      typeMirror.isAssignableTo(_mirList)) {
    final List<TypeMirror> typeArguments = typeMirror.typeArguments;
    _CmplxType typ;
    if (typeArguments[index].isAssignableTo(_mirMap)) {
      typ = _CmplxType.MAP;
    } else if (typeArguments[index].isAssignableTo(_mirList)) {
      typ = _CmplxType.LIST;
    } else if (_isPrimitive(typeArguments[index].reflectedType)) {
      typ = _CmplxType.PRIMITIVE;
    } else {
      typ = _CmplxType.OBJECT;
    }

    ele.ctype = ctype;
    ele.children = {
      "": new _Element.withSymbol(_emptySymbol,
          type: typeArguments[index].reflectedType, ctype: typ)
    };
    final _eleChildList =
        _generateElements(ele.children[""].type, isChild: true);
    ele.children[""] = _eleChildList;
    ele.children[""].ctype = typ;
    if (!isChild) _cache[type] = ele;
    return ele;
  }

  if (ele.typeSeeker != null) {
    ele.ctype == _CmplxType.TYPESEEKER;
    if (!isChild) _cache[type] = ele;
    return ele;
  }

  ele.ctype = _CmplxType.OBJECT;

  ele.children = new Map<String, _Element>();

  //check super class until we hit Object
  if (classMirror.superclass?.hasReflectedType ?? false) {
    if (classMirror.superclass.reflectedType != Object) {
      ele.children.addAll(
          _generateElements(classMirror.superclass.reflectedType, isChild: true)
              .children);
    }
  }
  //check fields
  classMirror.declarations.values
      .where((dm) => dm is VariableMirror)
      .forEach((dm) {
    if (dm is VariableMirror) {
      final chEle = new _Element.withSymbol(dm.simpleName);

      String key = MirrorSystem.getName(dm.simpleName);
      //check for annotation
      chEle.prop = getAnnotation(dm.metadata, Property) as Property;
      if (chEle.prop != null) {
        key = chEle.prop.name ?? key;
      }
      chEle.typeSeeker = getAnnotation(dm.metadata, TypeSeeker) as TypeSeeker;
      chEle.impl = getAnnotation(dm.metadata, Implementation) as Implementation;

      if (dm.type.hasReflectedType || chEle.impl != null) {
        Type chType = dm.type.reflectedType;
        if (chEle.impl != null) chType = chEle.impl.type;
        chEle.type = chType;
        chEle.cm = reflectClass(chType);

        if (_isPrimitive(chEle.type)) {
          chEle.ctype = _CmplxType.PRIMITIVE;
          ele.children[key] = chEle;
          return;
        }

        if (chEle.typeSeeker != null) {
          //might be map or list
          final _ele2 = _generateElements(chEle.type, isChild: true);
          if (_ele2.ctype == _CmplxType.LIST || _ele2.ctype == _CmplxType.MAP) {
            ele.children[key] = _ele2;
            ele.children[key].symbol = chEle.symbol;
            ele.children[key].children.values.first.typeSeeker =
                chEle.typeSeeker;
            ele.children[key].children.values.first.ctype =
                _CmplxType.TYPESEEKER;
            return;
          } else {
            chEle.ctype = _CmplxType.TYPESEEKER;
            ele.children[key] = chEle;
            return;
          }
        }

        ele.children[key] = _generateElements(chEle.type, isChild: true);
        ele.children[key].symbol = chEle.symbol;
      } else {
        ele.children[key] = chEle;
      }
    }
  });
  if (!isChild) _cache[type] = ele;
  return ele;
}

dynamic getAnnotation(List<InstanceMirror> l, Type type) {
  final mir = l.firstWhere((s) {
    if (!s.hasReflectee) return false;
    if (s.reflectee.runtimeType == type) return true;
    return false;
  }, orElse: () => null);
  if (mir?.hasReflectee ?? false) {
    return mir.reflectee;
  } else {
    return null;
  }
}
