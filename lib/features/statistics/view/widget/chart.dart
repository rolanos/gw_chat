import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gw_chat/core/extension.dart';
import 'package:gw_chat/core/model/user_list.dart';

class LineChartCustom extends StatefulWidget {
  const LineChartCustom({
    super.key,
    required this.userList,
    required this.rightTitle,
  });

  final UserList userList;
  final String rightTitle;

  @override
  State<LineChartCustom> createState() => _LineChartCustomState();
}

class _LineChartCustomState extends State<LineChartCustom> {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      mainData(
        widget.rightTitle,
        widget.userList,
        context,
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = context.theme.textTheme.labelMedium;
    Widget text;

    text = Text(value.toInt().toString(), style: style);

    if (value == 0) {
      text = const SizedBox();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = context.theme.textTheme.labelMedium;
    Widget text;
    double fraction = value - value.truncate();
    text = Text(
        fraction == 0 ? value.toInt().toString() : value.toStringAsFixed(1),
        style: style);

    if (value == 0) {
      text = const SizedBox();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }

  LineChartData mainData(
    String rightTitle,
    UserList userList,
    BuildContext context,
  ) {
    int max = 0;
    final spots = List.generate(
      userList.users.length,
      (i) => FlSpot(
        double.tryParse(userList.users[i].time ?? '') ?? 0,
        (userList.users[i].amount ?? 0).toDouble(),
      ),
    );
    for (var us in userList.users) {
      if ((us.amount ?? 0) > max) {
        max = us.amount ?? 0;
      }
    }
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: context.theme.dividerColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.transparent,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          axisNameWidget: RotatedBox(
            quarterTurns: 2,
            child: Text(
              rightTitle,
              style: context.theme.textTheme.labelSmall?.copyWith(fontSize: 12),
            ),
          ),
          sideTitles: const SideTitles(
            showTitles: false,
            reservedSize: 0,
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: max != 0
            ? AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 4 * 11,
                  interval: max / 5,
                  getTitlesWidget: leftTitleWidgets,
                ),
              )
            : const AxisTitles(
                sideTitles: SideTitles(
                  reservedSize: 44,
                  showTitles: true,
                ),
              ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 4,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: false,
          color: Colors.transparent,
          barWidth: 5,
          //isStrokeCapRound: true,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            color: context.theme.indicatorColor,
          ),
        ),
      ],
    );
  }
}
