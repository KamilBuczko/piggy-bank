import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skarbonka/providers/notifiers/expenses_provider.dart';
import 'package:skarbonka/providers/notifiers/plan_config_provider.dart';
import 'package:skarbonka/utils/mock/mocked_expenses.dart';
import 'package:skarbonka/utils/mock/mocked_plan.dart';
import 'package:skarbonka/utils/navigation.dart';

enum MenuOption { SETTINGS, DELETE_PLAN, GENERATE_PLAN }

class HomePagePopupMenu extends StatelessWidget {
  final bool isPlanEmpty;

  HomePagePopupMenu({@required this.isPlanEmpty});

  @override
  Widget build(BuildContext context) {
    List<PopupMenuItem<MenuOption>> menuItemList = _buildMenuItems();

    return PopupMenuButton<MenuOption>(
      icon: Icon(Icons.more_vert),
      onSelected: (value) => _onSelected(context, value),
      itemBuilder: (BuildContext context) => menuItemList,
    );
  }

  _onSelected(BuildContext context, MenuOption option) {
    switch (option) {
      case MenuOption.SETTINGS:
        navigateTo(context, AppRoute.SETTINGS);
        break;
      case MenuOption.DELETE_PLAN:
        _showWarningDialog(context);
        break;
      case MenuOption.GENERATE_PLAN:
        var planConfigProvider = Provider.of<PlanConfigProvider>(context, listen: false);
        var expensesProvider = Provider.of<ExpensesProvider>(context, listen: false);
        planConfigProvider.deletePlanConfig();
        expensesProvider.deleteExpenses();

        planConfigProvider.planConfig = MockedPlan.build();
        expensesProvider.expenses = MockedExpenses.build();
        break;
    }
  }

  List<PopupMenuItem<MenuOption>> _buildMenuItems() {
    List<PopupMenuItem<MenuOption>> itemList = [];

    // itemList.add(PopupMenuItem<MenuOption>(
    //     value: MenuOption.SETTINGS,
    //     child: MenuItemContent(icon: Icons.settings, text: "Ustawienia")));

    if (!isPlanEmpty) {
      itemList.add(PopupMenuItem<MenuOption>(
          value: MenuOption.DELETE_PLAN,
          child: MenuItemContent(icon: Icons.delete_outlined, text: "Usuń plan")));
    }

    itemList.add(PopupMenuItem<MenuOption>(
        value: MenuOption.GENERATE_PLAN,
        child: MenuItemContent(icon: Icons.handyman, text: "Generuj plan")));

    return itemList;
  }

  Future<void> _showWarningDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Usunąć plan?"),
          content:
                Text('Usunięcie planu spowoduje utratę wszytkich danych'),
          actions: <Widget>[
            TextButton(
              child: Text('Cofnij', style: TextStyle(color: Theme.of(context).accentColor, fontSize: 18.0)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Usuń', style: TextStyle(color: Theme.of(context).errorColor, fontSize: 18.0)),
              onPressed: () {
                var planConfigProvider = Provider.of<PlanConfigProvider>(context, listen: false);
                var expensesProvider = Provider.of<ExpensesProvider>(context, listen: false);
                planConfigProvider.deletePlanConfig();
                expensesProvider.deleteExpenses();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class MenuItemContent extends StatelessWidget {
  final IconData icon;
  final String text;

  MenuItemContent({@required this.icon, @required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).iconTheme.color),
        SizedBox(width: 8),
        Expanded(child: Text(text, style: TextStyle(fontSize: 17.0))),
      ],
    );
  }
}

