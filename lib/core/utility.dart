class Utility {
  static bool isNullOrEmpty(Object? object) {
    if (object == null) return true;
    if (object is String) return object.trim().isEmpty;
    if (object is Iterable) return object.isEmpty;
    if (object is Map) return object.keys.isEmpty;
    return false;
  }
}
