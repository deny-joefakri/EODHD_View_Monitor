
import 'package:eodhd_view_monitor/data/models/crypto_model.dart';

import '../../domain/repositories/crypto_repository.dart';
import '../datasources/socket/socket_datasource.dart';

class CryptoRepositoryImpl implements CryptoRepository {
  final SocketDataSource webSocketDataSource;

  CryptoRepositoryImpl({required this.webSocketDataSource});

  @override
  void closeWebSocket() {
    webSocketDataSource.closeWebSocket();
  }

  @override
  Future<void> openWebSocket(
      Function(CryptoModel crypto) onStream) async {
    await webSocketDataSource.connectWebSocket(onStream);
  }

  @override
  void subscribeToSymbols(String symbols) {
    webSocketDataSource.subscribeToSymbols(symbols);
  }
}