import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
import '../widgets/custom_keyboard.dart';

class GraphScreen extends StatefulWidget {
  const GraphScreen({super.key});

  @override
  State<GraphScreen> createState() => _GraphScreenState();
}

class _GraphScreenState extends State<GraphScreen> {
  String expression = "";
  int cursorPos = 0;
  List<FlSpot> points = [];

  final double originalMinX = -10, originalMaxX = 10, originalMinY = -10, originalMaxY = 10;

  double minX = -10, maxX = 10, minY = -10, maxY = 10;

  double zoomStep = 1.0;

  void updateGraph(String expr) {
    try {
      Parser p = Parser();
      Expression exp = p.parse(expr);
      ContextModel cm = ContextModel();

      List<FlSpot> newPoints = [];
      double step = (maxX - minX) / 320;
      for (double x = minX; x <= maxX; x += step) {
        cm.bindVariable(Variable('x'), Number(x));
        double y = exp.evaluate(EvaluationType.REAL, cm);
        if (y.isFinite && y >= minY && y <= maxY) {
          newPoints.add(FlSpot(x, y));
        }
      }

      setState(() {
        points = newPoints;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Invalid function!")),
      );
    }
  }

  void onKeyTap(String value) {
    setState(() {
      if (value == "C") {
        expression = "";
        cursorPos = 0;
        points.clear();
      } else if (value == "DEL") {
        if (cursorPos > 0) {
          expression =
              expression.substring(0, cursorPos - 1) +
                  expression.substring(cursorPos);
          cursorPos--;
        }
      } else if (value == "«") {
        if (cursorPos > 0) cursorPos--;
      } else if (value == "»") {
        if (cursorPos < expression.length) cursorPos++;
      } else if (value == "Draw") {
        updateGraph(expression);
      } else if (value == "x") {
        expression =
            expression.substring(0, cursorPos) +
                "x" +
                expression.substring(cursorPos);
        cursorPos++;
      } else {
        expression =
            expression.substring(0, cursorPos) +
                value +
                expression.substring(cursorPos);
        cursorPos += value.length;
      }
    });
  }

  void zoomIn() {
    setState(() {
      double newMinX = (minX + zoomStep).clamp(originalMinX, originalMaxX);
      double newMaxX = (maxX - zoomStep).clamp(originalMinX, originalMaxX);
      double newMinY = (minY + zoomStep).clamp(originalMinY, originalMaxY);
      double newMaxY = (maxY - zoomStep).clamp(originalMinY, originalMaxY);

      if (newMaxX - newMinX > 0 && newMaxY - newMinY > 0) {
        minX = newMinX;
        maxX = newMaxX;
        minY = newMinY;
        maxY = newMaxY;
      }

      updateGraph(expression);
    });
  }

  void zoomOut() {
    setState(() {
      double newMinX = (minX - zoomStep).clamp(originalMinX, originalMaxX);
      double newMaxX = (maxX + zoomStep).clamp(originalMinX, originalMaxX);
      double newMinY = (minY - zoomStep).clamp(originalMinY, originalMaxY);
      double newMaxY = (maxY + zoomStep).clamp(originalMinY, originalMaxY);

      if (newMaxX - newMinX > 0 && newMaxY - newMinY > 0) {
        minX = newMinX;
        maxX = newMaxX;
        minY = newMinY;
        maxY = newMaxY;
      }

      updateGraph(expression);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    final double fontSize = size.width * 0.05;
    final double padding = size.width * 0.04;
    final double cardMargin = size.width * 0.04;

    String displayExpression =
        '${expression.substring(0, cursorPos)}|${expression.substring(cursorPos)}';

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [theme.colorScheme.primary.withOpacity(0.1), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            SizedBox(height: kToolbarHeight + padding),

            Card(
              margin: EdgeInsets.symmetric(horizontal: cardMargin, vertical: padding / 2),
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: theme.colorScheme.surface.withOpacity(0.9),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: padding, vertical: padding / 1.5),
                child: Row(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          displayExpression,
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.w600,
                            fontFamily: "monospace",
                            color: displayExpression.isEmpty
                                ? theme.hintColor
                                : theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: Stack(
                children: [
                  Card(
                    margin: EdgeInsets.symmetric(horizontal: cardMargin, vertical: padding),
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(padding),
                      child: ClipRect(
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: 1),
                          duration: const Duration(seconds: 2),
                          builder: (context, value, child) {
                            final animatedPoints =
                            points.take((points.length * value).toInt()).toList();

                            return LineChart(
                              LineChartData(
                                minX: minX,
                                maxX: maxX,
                                minY: minY,
                                maxY: maxY,
                                gridData: FlGridData(
                                  show: true,
                                  drawVerticalLine: true,
                                  getDrawingHorizontalLine: (val) => FlLine(
                                    color: theme.dividerColor.withOpacity(0.9),
                                    strokeWidth: 1,
                                    dashArray: [6, 4],
                                  ),
                                  getDrawingVerticalLine: (val) => FlLine(
                                    color: theme.dividerColor.withOpacity(0.9),
                                    strokeWidth: 1,
                                    dashArray: [6, 4],
                                  ),
                                ),
                                titlesData: FlTitlesData(
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: true, reservedSize: size.width * 0.08, interval: 2),
                                  ),
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: true, reservedSize: size.height * 0.03, interval: 2),
                                  ),
                                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                                ),
                                borderData: FlBorderData(
                                  show: true,
                                  border: Border.all(color: theme.colorScheme.primary.withOpacity(0.5)),
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: animatedPoints,
                                    isCurved: true,
                                    color: theme.colorScheme.primary,
                                    barWidth: 3,
                                    isStrokeCapRound: true,
                                    dotData: FlDotData(show: false),
                                  ),
                                ],
                                lineTouchData: LineTouchData(
                                  handleBuiltInTouches: true,
                                  touchSpotThreshold: 10,
                                  touchTooltipData: LineTouchTooltipData(
                                    getTooltipItems: (touchedSpots) {
                                      return touchedSpots.map((spot) {
                                        return LineTooltipItem(
                                          'x: ${spot.x.toStringAsFixed(2)}, \ny: ${spot.y.toStringAsFixed(2)}',
                                          TextStyle(color: Colors.white,fontSize: fontSize * 0.8),
                                        );
                                      }).toList();
                                    },
                                  ),
                                ),
                              ),
                            );

                          },
                        ),
                      ),
                    ),
                  ),

                  Positioned(
                    right: padding,
                    bottom: padding,
                    child: Column(
                      children: [
                        FloatingActionButton(
                          mini: true,
                          heroTag: 'zoom_in',
                          onPressed: zoomIn,
                          child: const Icon(Icons.zoom_in),
                        ),
                        SizedBox(height: padding / 4),
                        FloatingActionButton(
                          mini: true,
                          heroTag: 'zoom_out',
                          onPressed: zoomOut,
                          child: const Icon(Icons.zoom_out),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            CustomKeyboard(onKeyTap: onKeyTap),
          ],
        ),
      ),
    );
  }
}
