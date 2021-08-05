import 'package:flutter/material.dart';
import 'package:flutter_budget_ui/data/color_helper.dart';
import 'package:flutter_budget_ui/models/category_model.dart';
import 'package:flutter_budget_ui/screens/category_page.dart';
import 'package:flutter_budget_ui/values/size_config.dart';

class CategoryWidget extends StatefulWidget {
  final Category category;
  final Animation? animation;

  const CategoryWidget(this.category, {this.animation, Key? key})
      : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  double percentRemain = 0.0;
  double totalSpent = 0.0;
  @override
  void initState() {
    super.initState();

    widget.category.expenses.forEach((element) {
      totalSpent = element.cost + totalSpent;
    });

    percentRemain =
        (widget.category.maxAmount - totalSpent) / widget.category.maxAmount;
  }

  @override
  Widget build(BuildContext context) {
    print('rebuild: ${this.runtimeType.toString()} build');

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CategoryPage(widget.category);
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: EdgeInsets.all(SizeConfig.padding),
        // height: 100.0,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(0, 2), blurRadius: 6.0)
            ]),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.category.name,
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  '\$${(widget.category.maxAmount - totalSpent).toStringAsFixed(2)} / \$${widget.category.maxAmount.toStringAsFixed(1)}',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: SizeConfig.padding * 2),
              child: LayoutBuilder(builder: (context, constraints) {
                var maxWidth = constraints.maxWidth;
                var remainWidth = percentRemain * maxWidth;
                if (remainWidth < 0) remainWidth = 0;

                var spentWith = maxWidth - remainWidth;

                var displayWidth =
                    maxWidth - (spentWith * widget.animation!.value);

                print('rebuild: ${this.runtimeType.toString()} LayoutBuilder');

                return Stack(
                  alignment: Alignment.centerRight,
                  children: [
                    Container(
                      height: 18.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    ),
                    Container(
                      height: SizeConfig.barThickness,
                      width: displayWidth,
                      decoration: BoxDecoration(
                        color: ColorHelper.getColor(percentRemain),
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                    )
                  ],
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
