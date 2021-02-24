import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class LineChartSample4 extends StatelessWidget {
  @override
  random(min, max) {
    Random rn = new Random();
    return min + (max - min) * rn.nextDouble();
  }

  Widget build(BuildContext context) {
    const cutOffYValue = 4.0;
    const dateTextStyle = TextStyle(
        fontSize: 10, color: secondaryText, fontWeight: FontWeight.bold);

    return SizedBox(
      width: 400,
      height: 170,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 1),
                FlSpot(1, random(1, 3)),
                FlSpot(2, random(1, 3)),
                FlSpot(3, random(1, 4)),
                FlSpot(4, random(1, 4)),
                FlSpot(5, random(3, 4)),
                FlSpot(6, random(2, 5)),
                FlSpot(7, random(3, 6)),
                FlSpot(8, random(3, 6)),
                FlSpot(9, random(4, 6)),
                FlSpot(10, random(4, 6)),
                FlSpot(11, random(5, 7)),
              ],
              isCurved: true,
              barWidth: 4,
              colors: [
                blueText,
              ],
              belowBarData: BarAreaData(
                show: true,
                colors: [Colors.greenAccent.withOpacity(0.35)],
                cutOffY: cutOffYValue,
                applyCutOffY: true,
              ),
              aboveBarData: BarAreaData(
                show: true,
                colors: [Colors.redAccent.withOpacity(0.35)],
                cutOffY: cutOffYValue,
                applyCutOffY: true,
              ),
              dotData: FlDotData(
                show: false,
              ),
            ),
          ],
          minY: 0,
          titlesData: FlTitlesData(
            bottomTitles: SideTitles(
                margin: 8,
                showTitles: true,
                reservedSize: 14,
                getTextStyles: (value) => dateTextStyle,
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 0:
                      return '';
                    case 1:
                      return '2011';
                    case 2:
                      return '';
                    case 3:
                      return '2013';
                    case 4:
                      return '';
                    case 5:
                      return '2015';
                    case 6:
                      return '';
                    case 7:
                      return '2017';
                    case 8:
                      return '';
                    case 9:
                      return '2019';
                    case 10:
                      return '';
                    case 11:
                      return '2021';
                    default:
                      return '';
                  }
                }),
            leftTitles: SideTitles(
              showTitles: true,
              margin: 9,
              getTextStyles: (value) => dateTextStyle,
              getTitles: (value) {
                return '\$ ${(value + 1).toInt()}00K';
              },
            ),
          ),
          axisTitleData: FlAxisTitleData(
              leftTitle: AxisTitle(
                  showTitle: true,
                  titleText: ' ',
                  textStyle: dateTextStyle,
                  margin: 8),
              bottomTitle: AxisTitle(
                  showTitle: true,
                  margin: 0,
                  titleText: '',
                  textStyle: dateTextStyle,
                  textAlign: TextAlign.right)),
          gridData: FlGridData(
            show: true,
            checkToShowHorizontalLine: (double value) {
              return value == 1 ||
                  value == 6 ||
                  value == 4 ||
                  value == 5 ||
                  value == 2 ||
                  value == 3;
            },
          ),
        ),
      ),
    );
  }
}
