part of _page;

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Log().build('Home page');
    Localizations.localeOf(context);
    
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('home'.i18n()),
        trailing: Button.texted(
          padding: EdgeInsets.zero,
          onPressed: () {
            showCupertinoModalBottomSheet(
              context: context,
              expand: true,
              barrierColor: CupertinoColors.darkBackgroundGray,
              useRootNavigator: true,
              enableDrag: false,
              builder: (context) => const AddPage(),
            );
            // Routemaster.of(context).push('/add');
          },
          child: const Icon(CupertinoIcons.add),
        )
      ),
      child: SingleChildScrollView(
        padding: GapPadding.all16S,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Gap.h32,
            Gap.h32,
            Gap.h32,
            Text('Total',
              style: TextTheme.caption.copyWith(
                color: TextColors.dynamicBaseColor(context)
              ),
            ),
            Gap.h4,
            Text('Rp1.000.000',
              style: TextTheme.h3.copyWith(
                color: TextColors.dynamicBaseColor(context)
              ),
            ),
            Gap.h16,
            UangkuMainChart(),
          ],
        ),
      )
    );
  }
}

class UangkuMainChart extends StatefulWidget {
  const UangkuMainChart({
    Key? key,
  }) : super(key: key);

  @override
  State<UangkuMainChart> createState() => _UangkuMainChartState();
}

class _UangkuMainChartState extends State<UangkuMainChart> {

  final List<FlSpot> dataThisWeek = const [
    FlSpot(1, 1),
    FlSpot(2, 1.5),
    FlSpot(3, 1.4),
    FlSpot(4, 3.4),
    FlSpot(5, 4),
    FlSpot(6, 3.9),
    FlSpot(7, 5),
  ];

  final List<FlSpot> dataThisMonth = const [
    FlSpot(1, 1),
    FlSpot(2, 1.5),
    FlSpot(3, 1.4),
    FlSpot(4, 3.4),
  ];

  final List<FlSpot> dataThisYear = const [
    FlSpot(1, 1),
    FlSpot(2, 1.5),
    FlSpot(3, 1.4),
    FlSpot(4, 3.4),
    FlSpot(5, 4),
    FlSpot(6, 3.9),
    FlSpot(7, 5),
    FlSpot(8, 6),
    FlSpot(9, 5),
    FlSpot(10, 5),
    FlSpot(11, 11),
    FlSpot(12, 4),
  ];

  String selectedOption = 'week';

  @override
  Widget build(BuildContext _) {

    final dataOptions = {
      'week': dataThisWeek,
      'month': dataThisMonth,
      'year': dataThisYear,
    };

    final maxXOptions = {
      'week': 7,
      'month': 8,
      'year': 12,
    };

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16/9,
          child: LineChart(
            LineChartData(
              lineBarsData: [
                LineChartBarData(
                  color: PrimaryColors.base,
                  spots: dataOptions[selectedOption],
                  isCurved: false,
                  barWidth: 4,
                  dotData: FlDotData(
                    show: false,
                  ),
                ),
              ],
              lineTouchData: LineTouchData(
                enabled: true,
                touchTooltipData: LineTouchTooltipData(
                  tooltipBgColor: PrimaryColors.transparent,
                  tooltipPadding: EdgeInsets.zero,
                  getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                    return touchedBarSpots.map((barSpot) {
                      return LineTooltipItem(
                        barSpot.y.toStringAsFixed(2),
                        TextTheme.bodySm.copyWith(
                          color: TextColors.dynamicBaseColor(context)
                        )
                      );
                    }).toList();
                  },
                ),
                getTouchedSpotIndicator: (barData, indicators) {
                  return indicators.map((int index) {
                    final flLine = FlLine(
                      color: TextColors.dynamicBaseColor(context).withOpacity(0.6),
                      strokeWidth: 1
                    );
                    final dotData = FlDotData(
                    getDotPainter: (spot, percent, bar, index) =>
                      FlDotCirclePainter(
                        radius: 8,
                        color: barData.color,
                        strokeWidth: 0
                      ),
                    );
                    return TouchedSpotIndicatorData(flLine, dotData);
                  }).toList();
                },
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (val, meta) => Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        val.toInt().toString(),
                        style: TextTheme.bodySm.copyWith(
                          color: TextColors.dynamicBaseColor(context)
                        ),
                      ),
                    ),
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false,),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(
                  color: resolveDynamicColor(
                    context,
                    color: CupertinoColors.systemGrey2.withOpacity(0.6),
                    darkColor: CupertinoColors.systemGrey2.withOpacity(0.4),
                  )
                ),
              ),
              maxX: maxXOptions[selectedOption]?.toDouble(),
            ),
            swapAnimationDuration: const Duration(milliseconds: 360),
            swapAnimationCurve: Curves.easeInOutQuart,
          ),
        ),
        Gap.h16,
        CupertinoSlidingSegmentedControl<String>(
          groupValue: selectedOption,
          onValueChanged: (value) {
            if (selectedOption != value) {
              setState(() => selectedOption = value!,);
            }
          },
          children: {
            'week': Text('this_week'.i18n(),
              style: TextStyle(
                color: TextColors.dynamicBaseColor(context),
              ),
            ),
            'month': Text('this_month'.i18n(),
              style: TextStyle(
                color: TextColors.dynamicBaseColor(context),
              ),
            ),
            'year': Text('this_year'.i18n(),
              style: TextStyle(
                color: TextColors.dynamicBaseColor(context),
              ),
            ),
          },
        ),
        Gap.h16,
      ],
    );
  }
}