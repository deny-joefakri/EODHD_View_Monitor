import 'package:eodhd_view_monitor/data/models/crypto_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart' hide TextDirection;

import '../blocs/crypto_bloc.dart';
import '../blocs/crypto_state.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../utils/general_view.dart';

class CryptoChart extends StatelessWidget {
  final String tickerCode;
  final Map<String, List<CryptoModel>> cryptoData;

  const CryptoChart({super.key, required this.tickerCode, required this.cryptoData});

  @override
  Widget build(BuildContext context) {
    if (tickerCode.isEmpty) {
      return const Center(child: Text('Please select a ticker'));
    }

    final List<CryptoModel> rawData = cryptoData[tickerCode] ?? [];
    final List<CryptoModel> chartData = _filterDataPerSecond(rawData);

    if (chartData.isEmpty) {
      return const Center(child: Text('No data available for the selected ticker'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Chart",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ).paddingAll(16),
        Divider(
          color: Colors.grey[300]?.withOpacity(0.5),
          thickness: 1,
          height: 1,
        ),
        Row(
          children: [
            SizedBox(
              width: 50,
              child: buildCryptoIcon(tickerCode),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tickerCode,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "Price Movement for ${getCryptoFullName(tickerCode)}",
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ).paddingSymmetric(vertical: 16, horizontal: 8),
        SfCartesianChart(
          plotAreaBorderWidth: 0,
          legend: const Legend(isVisible: false),
          tooltipBehavior: TooltipBehavior(enable: true),

          primaryXAxis: DateTimeAxis(
            title: const AxisTitle(text: 'Time'),
            intervalType: DateTimeIntervalType.seconds,
            interval: 20,  //
            edgeLabelPlacement: EdgeLabelPlacement.shift,
            dateFormat: DateFormat.Hms(),
            majorGridLines: const MajorGridLines(width: 1, dashArray: [5, 5], color: Colors.grey),
            majorTickLines: const MajorTickLines(size: 5, width: 2, color: Colors.grey),
            minorGridLines: const MinorGridLines(width: 1, dashArray: [5, 5], color: Colors.grey),
            labelStyle: const TextStyle(
              fontSize: 8,
              color: Colors.black,
            ),
          ),

          primaryYAxis: const NumericAxis(
            title: AxisTitle(text: 'Price (\$)'),
            labelFormat: '\${value}',
            majorGridLines: MajorGridLines(width: 1, dashArray: [5, 5], color: Colors.grey),
            majorTickLines: MajorTickLines(size: 5, width: 2, color: Colors.grey),
            minorGridLines: MinorGridLines(width: 1, dashArray: [5, 5], color: Colors.grey),
            labelStyle: const TextStyle(
              fontSize: 8,
              color: Colors.black,
            ),
          ),
          series: <FastLineSeries<CryptoModel, DateTime>>[
            FastLineSeries<CryptoModel, DateTime>(
              name: tickerCode,
              dataSource: chartData,
              color: Colors.lightBlueAccent,
              xValueMapper: (CryptoModel ticker, _) => ticker.timestamp,
              yValueMapper: (CryptoModel ticker, _) => ticker.lastPrice,
              enableTooltip: true,
            ),
          ],
          zoomPanBehavior: ZoomPanBehavior(
            enablePinching: true,
            enablePanning: true,
            enableSelectionZooming: true,
            zoomMode: ZoomMode.x,
          ),
        )
      ],
    );
  }

  /// Filters the raw data, keeping only the most recent data point per second.
  List<CryptoModel> _filterDataPerSecond(List<CryptoModel> rawData) {
    final Map<int, CryptoModel> filteredMap = {};

    for (var crypto in rawData) {
      int timestampInSeconds = crypto.timestamp.millisecondsSinceEpoch ~/ 1000;
      filteredMap[timestampInSeconds] = crypto; // Keep the latest data point for each second
    }

    return filteredMap.values.toList()..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }
}