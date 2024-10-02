
import 'package:bloc/bloc.dart';
import 'package:eodhd_view_monitor/data/models/crypto_model.dart';

import '../../core/text_constants.dart';
import '../../domain/usecases/get_crypto_usecase.dart';
import 'crypto_state.dart';

class CryptoSocketBloc extends Cubit<SocketState> {
  final SocketUseCase useCase;
  final String symbols;
  final Map<String, List<CryptoModel>> tickersMap = {};

  CryptoSocketBloc({required this.useCase, required this.symbols}) : super(SocketInitial()) {
    setupWebSocketListener();
  }

  Future<void> setupWebSocketListener() async {
    try {
      await useCase.openWebSocket((crypto) {

        if (crypto.tickerCode.isEmpty) {
          return;
        }

        tickersMap[crypto.tickerCode] = [
          if (tickersMap.containsKey(crypto.tickerCode)) ...tickersMap[crypto.tickerCode]!,
          crypto,
        ];

        emit(SocketCryptoReceived(tickersMap));

      });
      emit(SocketConnected(APPTextConstants.connected));

      subscribeToSymbols(symbols);
    } catch (e) {
      emit(SocketError(APPTextConstants.failed));
    }
  }

  void closeWebSocket() {
    useCase.closeWebSocket();
    emit(SocketClosed());
  }

  void subscribeToSymbols(String symbols) {
    useCase.subscribeToSymbols(symbols);
  }


}
