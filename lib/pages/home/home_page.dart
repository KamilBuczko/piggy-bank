import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:skarbonka/pages/home/expense/expense_tab_view.dart';
import 'package:skarbonka/pages/home/satistics/statistics_tab_view.dart';
import 'package:skarbonka/providers/notifiers/plan_config_provider.dart';

import '../../utils/navigation.dart';
import 'home_page_popup_menu.dart';

class HomePage extends StatefulWidget {
  final String title = "Skarbonka";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanConfigProvider>(
        builder: (BuildContext context, planConfigProvider, Widget child) {
      return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.title,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27.0,
                  letterSpacing: 1.5),
            ),
            bottom: planConfigProvider.isNotEmpty
                ? _getTabBar(context, _tabController)
                : null,
            actions: [
              HomePagePopupMenu(isPlanEmpty: planConfigProvider.isEmpty)
            ],
          ),
          body: planConfigProvider.isEmpty
              ? PlaceholderHomeBody(planConfigProvider.loaded)
              : HomeBody(
                  controller: _tabController,
                ));
    });
  }

  TabBar _getTabBar(BuildContext context, TabController controller) {
    return TabBar(
      controller: controller,
      labelColor: Theme.of(context).accentColor,
      unselectedLabelColor: Theme.of(context).primaryColorLight,
      tabs: [
        Tab(
          icon: Icon(
            Icons.attach_money,
            size: 27.5,
          ),
          child: Text("WYDATKI", style: TextStyle(fontSize: 15.0)),
        ),
        Tab(
          icon: Icon(
            Icons.bar_chart,
            size: 25.5,
          ),
          child: Text("STATYSTYKI", style: TextStyle(fontSize: 15.0)),
        ),
      ],
    );
  }
}

class PlaceholderHomeBody extends StatelessWidget {
  final bool loaded;

  PlaceholderHomeBody(this.loaded);

  @override
  Widget build(BuildContext context) {
    return loaded
        ? Center(
            child: ButtonTheme(
              minWidth: 200.0,
              height: 50.0,
              child: RaisedButton(
                onPressed: () =>
                    navigateTo(context, AppRoute.PLAN_CONFIGURATION),
                textTheme: ButtonTextTheme.primary,
                color: Theme.of(context).primaryColor,
                child: Text(
                  'Zacznij oszczędzać!',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            ),
          )
        : Container();
  }
}

class HomeBody extends StatelessWidget {
  final TabController controller;

  HomeBody({@required this.controller});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
        controller: controller,
        children: [ExpenseTabView(), StatisticsTabView()]);
  }
}
