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

class _CategoryPageState extends State<CategoryPage>
    with SingleTickerProviderStateMixin {
  double totalSpent = 0.0;
  double amountRemain = 0.0;
  double percentRemain = 0.0;

  late final AnimationController animationController;
  late final Animation _animation;

  @override
  void initState() {
    super.initState();

    widget.category.expenses.forEach((element) {
      totalSpent += element.cost;
    });

    amountRemain = widget.category.maxAmount - totalSpent;
    percentRemain = amountRemain / widget.category.maxAmount;

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    animationController.addListener(() {
      setState(() {});
    });

    _animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInSine);
    animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
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
      child: LayoutBuilder(builder: (context, constraints) {
        double spentPercent = 1.0 - percentRemain;

        double displayPercent = 1.0 - _animation.value * spentPercent;
        double displayAmount =
            widget.category.maxAmount - _animation.value * totalSpent;

        return CustomPaint(
          foregroundPainter: RadialPainter(
              bgColor: Colors.grey[200]!,
              lineColor: ColorHelper.getColor(percentRemain),
              thickness: SizeConfig.barThickness,
              percent: displayPercent),
          child: Center(
            child: Text(
              '\$${displayAmount.toStringAsFixed(2)} / \$${widget.category.maxAmount.toStringAsFixed(1)}',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ),
        );
      }),
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

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }
}
