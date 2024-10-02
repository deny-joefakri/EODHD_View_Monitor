import 'package:eodhd_view_monitor/data/models/crypto_model.dart';

abstract class CryptoRepository {
  Future<void> openWebSocket(Function(CryptoModel crypto) onStream);
  void closeWebSocket();
  void subscribeToSymbols(String symbols);
}