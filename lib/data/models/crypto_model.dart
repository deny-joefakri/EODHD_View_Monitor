import 'package:intl/intl.dart';

class CryptoModel {
  final String tickerCode;
  final double lastPrice;
  final double quantityOfTrade;
  final double dailyChangePercentage;
  final double dailyDifferencePrice;
  final int time;
  final DateTime timestamp;

  CryptoModel({
    required this.tickerCode,
    required this.lastPrice,
    required this.quantityOfTrade,
    required this.dailyChangePercentage,
    required this.dailyDifferencePrice,
    required this.time,
    required this.timestamp,
  });

  // Factory constructor for creating a new instance from a JSON map
  factory CryptoModel.fromJson(Map<String, dynamic> json) {
    return CryptoModel(
      tickerCode: handleNullString(json['s']),
      lastPrice: parseToDouble(json['p']),
      quantityOfTrade: parseToDouble(json['q']),
      dailyChangePercentage: parseToDouble(json['dc']),
      dailyDifferencePrice: parseToDouble(json['dd']),
      time: parseToInt(json['t']),
      timestamp: DateTime.fromMillisecondsSinceEpoch(parseToInt(json['t'])),
    );
  }

  // Method for converting a CryptoModel instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'tickerCode': tickerCode,
      'lastPrice': lastPrice,
      'quantityOfTrade': quantityOfTrade,
      'dailyChangePercentage': dailyChangePercentage,
      'dailyDifferencePrice': dailyDifferencePrice,
      'time': time,
      'timestamp': timestamp,
    };
  }

  // Returns formatted values for UI display
  String get formattedPrice => formatCurrency(lastPrice);
  String get formattedQuantity => formatQuantity(quantityOfTrade);
  String get formattedDailyChangePercentage => formatPercentage(dailyChangePercentage);
  String get formattedDailyDifferencePrice => formatCurrency(dailyDifferencePrice);
}

// Utility Functions

// Handles null strings, returning an empty string if null
String handleNullString(String? value) => value ?? '';

// Parses any dynamic value to double safely, with fallback cases
double parseToDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is int) return value.toDouble();
  if (value is double) return value;
  if (value is String) return double.tryParse(value) ?? 0.0;
  throw ArgumentError('Unsupported type for parsing to double: ${value.runtimeType}');
}

// Parses any dynamic value to int safely, with fallback cases
int parseToInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  throw ArgumentError('Unsupported type for parsing to int: ${value.runtimeType}');
}

// Formatting currency with 2 decimal places for USD
String formatCurrency(double amount) {
  final formatter = NumberFormat.currency(
    locale: 'en_US',
    symbol: '\$',
    decimalDigits: 2,
  );
  return formatter.format(amount);
}

// Formatting percentages with 2 decimal places
String formatPercentage(double value) {
  final formatter = NumberFormat.percentPattern('en_US');
  return formatter.format(value / 100);
}

// Formatting quantities with 4 decimal places for precision
String formatQuantity(double quantity) {
  final formatter = NumberFormat('##0.0000');
  return formatter.format(quantity);
}