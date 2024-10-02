
import 'dart:convert';

import 'package:eodhd_view_monitor/core/env/env.dart';
import 'package:eodhd_view_monitor/data/models/crypto_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

abstract class SocketDataSource {
  Future<void> connectWebSocket(Function(CryptoModel crypto) onStream);
  void subscribeToSymbols(String symbols);
  Future<void> closeWebSocket();
}

class SocketDataSourceImpl implements SocketDataSource {
  WebSocketChannel? _channel;

  @override
  Future<void> closeWebSocket() async {
    if (_channel != null) {
      await _channel!.sink.close();
      _channel = null;
    }
  }


  @override
  Future<void> connectWebSocket(Function(CryptoModel crypto) onStream) async {

    _channel =
        WebSocketChannel.connect(Uri.parse(baseUrlString));

    _channel!.stream.listen((message) {
      final data = jsonDecode(message);
      // print(data);
      onStream(CryptoModel.fromJson(data));
    });
  }

  @override
  void subscribeToSymbols(String symbols) {
    final request = jsonEncode({
      "action": "subscribe",
      "symbols": symbols,
    });
    _channel?.sink.add(request);
  }

}