


import 'package:eodhd_view_monitor/data/models/crypto_model.dart';
import 'package:eodhd_view_monitor/presentation/blocs/crypto_bloc.dart';
import 'package:eodhd_view_monitor/presentation/page/stock_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../blocs/crypto_state.dart';


import '../utils/general_view.dart';
import 'crypto_chart.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> with WidgetsBindingObserver  {
  late CryptoSocketBloc _cryptoSocketBloc;
  String? _selectedTicker;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _cryptoSocketBloc = Get.find<CryptoSocketBloc>();
    _cryptoSocketBloc.setupWebSocketListener();
  }

  @override
  void dispose() {
    _cryptoSocketBloc.closeWebSocket();
    _cryptoSocketBloc.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _cryptoSocketBloc.closeWebSocket();
      _cryptoSocketBloc.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildWatchlistCard(),
                const SizedBox(height: 20),
                _buildChartSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWatchlistCard() {
    return _buildDecoratedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          Divider(color: Colors.grey[300]?.withOpacity(0.5), thickness: 1, height: 1),
          BlocBuilder<CryptoSocketBloc, SocketState>(
            bloc: _cryptoSocketBloc,
            builder: (context, state) {
              if (state is SocketCryptoReceived) {
                return SizedBox(
                  height: 200,
                  child: _buildList(state.tickersMap),
                );
              } else if (state is SocketConnected) {
                return _buildMessage("Connected. Waiting for data...");
              } else if (state is SocketError) {
                return _buildErrorMessage(state.errorMessage);
              } else if (state is SocketClosed) {
                return _buildMessage("WebSocket Closed");
              } else {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildChartSection() {
    return BlocBuilder<CryptoSocketBloc, SocketState>(
      bloc: _cryptoSocketBloc,
      builder: (context, state) {
        if (state is SocketCryptoReceived && _selectedTicker != null && _selectedTicker!.isNotEmpty) {
          return _buildDecoratedContainer(
            child: CryptoChart(
              tickerCode: _selectedTicker!,
              cryptoData: state.tickersMap,
            ),
          );
        } else if (state is SocketCryptoReceived) {
          return const SizedBox();
        } else if (state is SocketError) {
          return _buildErrorMessage(state.errorMessage);
        } else if (state is SocketClosed) {
          return _buildMessage("WebSocket Closed");
        } else {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _buildDecoratedContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: child,
    );
  }

  Widget _buildHeader() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Watchlist",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          Row(
            children: [
              Icon(Icons.circle, size: 6, color: Colors.black),
              SizedBox(width: 4),
              Icon(Icons.circle, size: 6, color: Colors.black),
              SizedBox(width: 4),
              Icon(Icons.circle, size: 6, color: Colors.black),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildList(Map<String, List<CryptoModel>> cryptoData) {
    if (cryptoData.isEmpty) {
      return const Center(child: Text('No data available.'));
    }

    final cryptoList = cryptoData.entries.toList();

    return ListView.builder(
      itemCount: cryptoList.length,
      itemBuilder: (context, index) {
        final cryptoEntry = cryptoList[index];
        final latestCrypto = cryptoEntry.value.last;

        return StockCard(
          key: ValueKey(latestCrypto.tickerCode),
          crypto: latestCrypto,
          onTap: () {
            setState(() {
              _selectedTicker = latestCrypto.tickerCode;
            });
          },
        );
      },
    );
  }

  Widget _buildMessage(String message) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(child: Text(message)),
    );
  }

  Widget _buildErrorMessage(String errorMessage) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          'Error: $errorMessage',
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}




