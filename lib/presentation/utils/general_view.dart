

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import 'enum_crypto.dart';

Widget buildCryptoIcon(String tickerCode) {
  final CryptoTicker ticker = getCryptoTicker(tickerCode);

  // You can add the correct SVG asset paths for each enum case
  switch (ticker) {
    case CryptoTicker.BTC:
      return SvgPicture.asset(
        'assets/svg/ic_btc.svg',
        width: 40,
        height: 40,
      );
    case CryptoTicker.ETH:
      return SvgPicture.asset(
        'assets/svg/ic_eth.svg',
        width: 40,
        height: 40,
      );
    default:
      return SvgPicture.asset(
        'assets/icons/ic_btc.svg',
        width: 40,
        height: 40,
      );
  }
}

// Helper function to get the enum from the ticker code
CryptoTicker getCryptoTicker(String tickerCode) {
  switch (tickerCode.toUpperCase()) {
    case 'BTC-USD':
      return CryptoTicker.BTC;
    case 'ETH-USD':
      return CryptoTicker.ETH;
    case 'AVA-USD':
      return CryptoTicker.AVA;
    case 'BNC-USD':
      return CryptoTicker.BNC;
    default:
      return CryptoTicker.BTC;
  }
}

// Helper function to get the full name of the cryptocurrency from the ticker code
String getCryptoFullName(String tickerCode) {
  final CryptoTicker ticker = getCryptoTicker(tickerCode);

  switch (ticker) {
    case CryptoTicker.BTC:
      return 'Bitcoin';
    case CryptoTicker.ETH:
      return 'Ethereum';
    case CryptoTicker.AVA:
      return 'Avalanche';
    case CryptoTicker.BNC:
      return 'Binance Coin';
    default:
      return 'Unknown';
  }
}