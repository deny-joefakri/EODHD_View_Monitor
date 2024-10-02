

import 'dart:async';

import 'package:eodhd_view_monitor/data/models/crypto_model.dart';
import 'package:eodhd_view_monitor/domain/repositories/crypto_repository.dart';

class SocketUseCase {
  final CryptoRepository repository;

  final StreamController<CryptoModel> _cryptoController =  StreamController<CryptoModel>();
  Stream<CryptoModel> get locationStream => _cryptoController.stream;

  SocketUseCase({required this.repository});

  Future<void> openWebSocket(
      Function(CryptoModel crypto) onLocationReceived) async {
    await repository.openWebSocket(onLocationReceived);
  }

  void subscribeToSymbols(String symbols) {
    repository.subscribeToSymbols(symbols);
  }

  void closeWebSocket() {
    repository.closeWebSocket();
  }

  void dispose() {
    _cryptoController.close();
  }
}