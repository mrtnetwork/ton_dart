extension QuickOnList<T> on List<T> {
  List<T> get mutabl {
    return List<T>.unmodifiable(this);
  }
}

extension QuickOnMap<K, V> on Map<K, V> {
  Map<K, V> get mutabl {
    return Map<K, V>.unmodifiable(this);
  }

  Map<K, V>? get nullOnEmpty {
    if (isEmpty) return null;
    return mutabl;
  }
}

typedef ObjectConvertable<T, E> = T Function(E result);

extension QuickTo on Object {
  T to<T, E>(ObjectConvertable<T, E> fun) {
    return fun(this as E);
  }
}

typedef BooleanConvertable<T> = T Function();

extension QuickBool on bool {
  T? onTrue<T>(BooleanConvertable<T> onTrue) {
    if (this) {
      return onTrue();
    }
    return null;
  }
}
