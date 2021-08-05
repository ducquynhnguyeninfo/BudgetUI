import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/data/color_helper.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/models/expense_model.dart';
import 'package:flutter_budget_ui/values/size_config.dart';
import 'package:flutter_budget_ui/widgets/radial_painter.dart';

class CategoryPage extends StatefulWidget {
  final Category category;
  CategoryPage(this.category, {Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    double totalSpent = 0.0;
    widget.category.expenses.forEach((element) {
      totalSpent += element.cost;
    });

    final double amountRemain = widget.category.maxAmount - totalSpent;
    final double percentRemain = amountRemain / widget.category.maxAmount;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.category.name),
          backgroundColor: ColorHelper.getColor(percentRemain),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(Icons.add),
                iconSize: SizeConfig.iconSize)
          ],
        ),
        body: ListView.builder(
            itemBuilder: (context, index) {
              if (index == 0)
                return _buildRemainingRingChart(percentRemain, amountRemain);
              else
                return _buildExpenseItem(widget.category.expenses[index - 1]);
            },
            itemCount: widget.category.expenses.length + 1));
  }

  Container _buildRemainingRingChart(
      double percentRemain, double amountRemain) {
    return Container(
      height: 250,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(SizeConfig.borderRadius),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 2), blurRadius: 6.0)
          ]),
      child: CustomPaint(
        foregroundPainter: RadialPainter(
            bgColor: Colors.grey[200]!,
            lineColor: ColorHelper.getColor(percentRemain),
            thickness: 18,
            percent: percentRemain),
        child: Center(
          child: Text(
            '\$${amountRemain.toStringAsFixed(2)} / \$${widget.category.maxAmount.toStringAsFixed(1)}',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildExpenseItem(Expense expense) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(SizeConfig.borderRadius),
          boxShadow: [
            BoxShadow(
                color: Colors.black12, offset: Offset(0, 2), blurRadius: 6.0)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            expense.name,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          ),
          Text(
            '-\$${expense.cost.toStringAsFixed(2)}',
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 18, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
