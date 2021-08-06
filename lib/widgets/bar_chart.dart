import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/values/size_config.dart';

class BarChart extends StatelessWidget {
  final List<double> expenses;
  late final Animation<double> animation;

  BarChart(this.expenses, {Key? key, required Animation<double> animation})
      : super(key: key) {
    this.animation =
        CurvedAnimation(parent: animation, curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;

    expenses.forEach((element) {
      if (element > mostExpensive) {
        mostExpensive = element;
      }
    });
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
                  children: expenses.isEmpty
                      ? [
                          const SizedBox(
                            width: 100,
                            height: 100,
                          )
                        ]
                      : [
                          Bar(
                            label: 'Sun',
                            amountSpent: expenses[0],
                            mostExpensive: mostExpensive,
                            animation: animation,
                          ),
                          Bar(
                            label: 'Mon',
                            amountSpent: expenses[1],
                            mostExpensive: mostExpensive,
                            animation: animation,
                          ),
                          Bar(
                            label: 'Tue',
                            amountSpent: expenses[2],
                            mostExpensive: mostExpensive,
                            animation: animation,
                          ),
                          Bar(
                            label: 'Wed',
                            amountSpent: expenses[3],
                            mostExpensive: mostExpensive,
                            animation: animation,
                          ),
                          Bar(
                            label: 'Thus',
                            amountSpent: expenses[4],
                            mostExpensive: mostExpensive,
                            animation: animation,
                          ),
                          Bar(
                            label: 'Fri',
                            amountSpent: expenses[5],
                            mostExpensive: mostExpensive,
                            animation: animation,
                          ),
                          Bar(
                            label: 'Sat',
                            amountSpent: expenses[6],
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

class Bar extends AnimatedWidget {
  final String label;
  final double amountSpent;
  final double mostExpensive;

  const Bar(
      {Key? key,
      required this.label,
      required this.amountSpent,
      required this.mostExpensive,
      required Animation<double> animation})
      : super(key: key, listenable: animation);

  final double _maxBarHeight = 150.0;

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive * _maxBarHeight;
    Animation<double> animation = listenable as Animation<double>;

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
