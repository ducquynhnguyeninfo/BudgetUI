import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/values/size_config.dart';

class BarChart extends StatefulWidget {
  final List<double> expenses;
  final Animation<double> animation;

  const BarChart(this.expenses, {Key? key, required this.animation})
      : super(key: key);

  @override
  _BarChartState createState() => _BarChartState();
}

class _BarChartState extends State<BarChart>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    animation =
        CurvedAnimation(parent: widget.animation, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;

    widget.expenses.forEach((element) {
      if (element > mostExpensive) {
        mostExpensive = element;
      }
    });
    // animationController.forward();

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('Weekly spending',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
        SizedBox(height: 5.0),
        Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back,
                  size: 30,
                )),
            Expanded(
                child: Text('Nov 10, 2020 - Nov 16, 2020',
                    textAlign: TextAlign.center)),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward,
                  size: 30,
                )),
          ],
        ),
        SizedBox(height: 20),
        LayoutBuilder(builder: (context, constraints) {
          return Container(
              // color: Colors.red,
              width: constraints.maxWidth,
              height: constraints.maxWidth * 2 / 3,
              alignment: Alignment.bottomCenter,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Bar(
                      label: 'Sun',
                      amountSpent: widget.expenses[0],
                      mostExpensive: mostExpensive,
                      animation: animation,
                    ),
                    Bar(
                      label: 'Mon',
                      amountSpent: widget.expenses[1],
                      mostExpensive: mostExpensive,
                      animation: animation,
                    ),
                    Bar(
                      label: 'Tue',
                      amountSpent: widget.expenses[2],
                      mostExpensive: mostExpensive,
                      animation: animation,
                    ),
                    Bar(
                      label: 'Wed',
                      amountSpent: widget.expenses[3],
                      mostExpensive: mostExpensive,
                      animation: animation,
                    ),
                    Bar(
                      label: 'Thus',
                      amountSpent: widget.expenses[4],
                      mostExpensive: mostExpensive,
                      animation: animation,
                    ),
                    Bar(
                      label: 'Fri',
                      amountSpent: widget.expenses[5],
                      mostExpensive: mostExpensive,
                      animation: animation,
                    ),
                    Bar(
                      label: 'Sat',
                      amountSpent: widget.expenses[6],
                      mostExpensive: mostExpensive,
                      animation: animation,
                    ),
                  ],
                ),
              ));
        })
      ],
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpensive;
  final Animation<double> animation;

  const Bar(
      {Key? key,
      required this.label,
      required this.amountSpent,
      required this.mostExpensive,
      required this.animation})
      : super(key: key);

  final double _maxBarHeight = 150.0;

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive * _maxBarHeight;

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text('\$${(amountSpent * animation.value).toStringAsFixed(1)}',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Container(
            height: barHeight * animation.value,
            width: SizeConfig.barThickness,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(SizeConfig.borderRadius)),
          ),
        ),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
        ),
      ],
    );
  }
}
