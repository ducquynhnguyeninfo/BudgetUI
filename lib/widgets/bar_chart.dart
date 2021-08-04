import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/values/size_config.dart';
import 'package:flutter_budget_ui/values/values.dart';

import '../models/expense_model.dart';

class BarChart extends StatelessWidget {
  final List<double> expenses;

  const BarChart(this.expenses, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double mostExpensive = 0;

    expenses.forEach((element) {
      if (element > mostExpensive) {
        mostExpensive = element;
      }
    });

    return Column(
      children: [
        Text('weekly spending'),
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
        SizedBox(height: 30),
        FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Bar(
                  label: 'Sun',
                  amountSpent: expenses[0],
                  mostExpensive: mostExpensive),
              Bar(
                  label: 'Mon',
                  amountSpent: expenses[1],
                  mostExpensive: mostExpensive),
              Bar(
                  label: 'Tue',
                  amountSpent: expenses[2],
                  mostExpensive: mostExpensive),
              Bar(
                  label: 'Wed',
                  amountSpent: expenses[3],
                  mostExpensive: mostExpensive),
              Bar(
                  label: 'Thus',
                  amountSpent: expenses[4],
                  mostExpensive: mostExpensive),
              Bar(
                  label: 'Fri',
                  amountSpent: expenses[5],
                  mostExpensive: mostExpensive),
              Bar(label: 'Sat', amountSpent: expenses[6], mostExpensive: 200),
            ],
          ),
        )
      ],
    );
  }
}

class Bar extends StatelessWidget {
  final String label;
  final double amountSpent;
  final double mostExpensive;

  final double _maxBarHeight = 100.0;

  const Bar(
      {Key? key,
      required this.label,
      required this.amountSpent,
      required this.mostExpensive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final barHeight = amountSpent / mostExpensive * _maxBarHeight;

    return Column(
      children: [
        Text('\$${amountSpent.toStringAsFixed(2)}'),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Container(
            height: barHeight,
            width: SizeConfig.barThickness,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.all(SizeConfig.borderRadius)),
          ),
        ),
        Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ],
    );
  }
}
