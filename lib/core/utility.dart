class Utility {

  static bool isNullOrEmpty(object) {
    if (object == null) return true;
    if (object is String) return object.trim().isEmpty;
    if (object is Iterable) return object.length == 0;
    if (object is Map) return object.keys.length == 0;
    return false;
  }
}
