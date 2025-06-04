import 'dart:convert';

class JsonParser{
  static int intParse(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is double) {
      return value.round();
    } else if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0; // Default value if parsing fails
  }
  static double doubleParse(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is int) {
      return value.toDouble();
    } else if (value is String) {
      return double.tryParse(value) ?? 0.0;
    }
    return 0.0; // Default value if parsing fails
  }

  static DateTime dateTimeParse(dynamic value) {
    if (value is DateTime) {
      return value;
    } else if (value is String) {
      return DateTime.tryParse(value) ?? DateTime.now();
    }
    return DateTime.now(); // Default value if parsing fails
  }

  static String stringParse(dynamic value) {
    if (value is String) {
      return value;
    } else if (value is int || value is double) {
      return value.toString();
    }
    return ''; // Default value if parsing fails
  }

  static Map<String, dynamic> mapParse(dynamic value) {
    if (value.runtimeType == Map<String, dynamic>) {
      return value;
    } else if (value.runtimeType ==  String) {
      try {
        return jsonDecode(value);
      } catch (e) {
        return {}; // Return empty map if parsing fails
      }
    }
    else if(value.runtimeType == dynamic){
      return Map<String, dynamic>.from(value);
    }
    return {}; // Default value if parsing fails
  }
}