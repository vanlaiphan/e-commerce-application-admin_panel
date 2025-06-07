import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/icons/t_circular_icon.dart';
import 'package:yt_ecommerce_admin_panel/common/widgets/loaders/loader_animation.dart';

import '../../../../../common/widgets/containers/rounded_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../controllers/dashboard/dashboard_controller.dart';

class TWeeklySalesGraph extends StatelessWidget {
  const TWeeklySalesGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = DashboardController.instance;
    return TRoundedContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              TCircularIcon(
                icon: Iconsax.graph,
                backgroundColor: Colors.brown.withOpacity(0.1),
                color: Colors.brown,
                size: TSizes.md,
              ),
              const SizedBox(width: TSizes.spaceBtwItems),
              Text('Weekly Sales', style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
          const SizedBox(height: TSizes.spaceBtwSections),

          // Graph
          Obx(
            () => controller.weeklySales.isNotEmpty
                ? SizedBox(
                    height: 400,
                    child: BarChart(
                      BarChartData(
                        titlesData: buildFlTitlesData(controller.weeklySales),
                        borderData: FlBorderData(
                          show: true,
                          border: const Border(top: BorderSide.none, right: BorderSide.none),
                        ),
                        gridData: const FlGridData(
                          show: true,
                          drawHorizontalLine: true,
                          drawVerticalLine: true,
                          horizontalInterval: 200,
                        ),
                        barGroups: controller.weeklySales
                            .asMap()
                            .entries
                            .map(
                              (entry) => BarChartGroupData(
                                x: entry.key,
                                barRods: [
                                  BarChartRodData(
                                    width: 30,
                                    toY: entry.value,
                                    color: TColors.primary,
                                    borderRadius: BorderRadius.circular(TSizes.sm),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                        groupsSpace: TSizes.spaceBtwItems,
                        barTouchData: BarTouchData(
                          touchTooltipData: BarTouchTooltipData(getTooltipColor: (_) => TColors.secondary),
                          touchCallback: TDeviceUtils.isDesktopScreen(context) ? (barTouchEvent, barTouchResponse) {} : null,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(height: 400, child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [TLoaderAnimation()])),
          ),
        ],
      ),
    );
  }

  FlTitlesData buildFlTitlesData(List<double> weeklySales) {
    // Calculate Step height for the left pricing
    double maxOrder = weeklySales.reduce((a, b) => a > b ? a : b).toDouble();
    double stepHeight = (maxOrder / 10).ceilToDouble();

    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            // Map index to the desired day of the week
            final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

            // Calculate the index and ensure it wraps around for the correct day
            final index = value.toInt() % days.length;

            // Get the day corresponding to the calculated index
            final day = days[index];

            return SideTitleWidget(
              space: 0,
              axisSide: AxisSide.bottom,
              child: Text(day),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, interval: stepHeight <= 0 ? 500 : stepHeight, reservedSize: 50)),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }
}
