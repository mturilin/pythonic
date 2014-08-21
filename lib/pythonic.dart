library pythonic;

import 'dart:mirrors';

Object getattr(Object obj, String attr, {Object default_result: null}) {
    InstanceMirror mirror = reflect(obj);
    if (hasattr(obj, attr)) {
        return mirror.getField(new Symbol(attr));
    } else {
        return default_result;
    }
}


void setattr(Object obj, String attr, Object value) {
    InstanceMirror mirror = reflect(obj);
    if (hasattr(obj, attr)) {
        mirror.setField(new Symbol(attr), value);
    } else {
        throw new ArgumentError('Unknown field ${attr}');
    }
}


bool hasattr(Object obj, String attr) {
    InstanceMirror mirror = reflect(obj);
    ClassMirror class_mirror = mirror.type;
    return class_mirror.instanceMembers.containsKey(new Symbol(attr));
}

bool is_nothing(obj) {
    return obj == null || obj == 0 || obj == '' || obj == [] || ((obj is Iterable || obj is Map) && obj.length == 0);
}

bool is_something(obj) => !is_nothing(obj);


if_nothing(Object main_value, Object default_value) {
    if (is_nothing(main_value)) {
        return default_value;
    }

    return main_value;
}
