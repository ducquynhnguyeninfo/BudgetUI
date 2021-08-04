import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/data/data.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/widgets/bar_chart.dart';
import 'package:flutter_budget_ui/widgets/category_widget.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            forceElevated: true,
            floating: true,
            expandedHeight: 100,
            leading: Icon(Icons.settings),
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Budget'),
            ),
            actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
          ),
          SliverList(
            delegate:
                SliverChildBuilderDelegate((BuildContext context, int index) {
              if (index == 0) {
                return Container(
                  // height: 200,

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 2),
                            blurRadius: 6.0)
                      ]),
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(10),
                  child: BarChart(weeklySpending),
                );
              } else {
                final Category category = categories[index - 1];

                return CategoryWidget(category);
              }
            }, childCount: 1 + categories.length),
          )
        ],
      ),
    );
  }
}
