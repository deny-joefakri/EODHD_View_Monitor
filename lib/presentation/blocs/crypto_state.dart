import 'package:eodhd_view_monitor/data/models/crypto_model.dart';
import 'package:equatable/equatable.dart';

abstract class SocketState {}

class SocketInitial extends SocketState {}

class SocketConnected extends SocketState {
  final String message;

  SocketConnected(this.message);
}

class SocketClosed extends SocketState {}

class SocketError extends SocketState {
  final String errorMessage;

  SocketError(this.errorMessage);
}

class SocketCryptoReceived extends SocketState {
  final Map<String, List<CryptoModel>> tickersMap;

  SocketCryptoReceived(this.tickersMap);
}
