import 'package:dashboard_repository/dashboard_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:so/dashboard/bloc/dashboard_event.dart';
import 'package:so/dashboard/view/account_page.dart';
import 'package:so/dashboard/view/home_page.dart';
import 'package:so/widgets/customeAppBar.dart';
import '../bloc/dashboard_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(builder: (_) {
      return BlocProvider(
        create: (context) =>
            DashboardBloc(dashboardRepository: DashboardRepository()),
        child: const DashboardPage(),
      );
    });
  }

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 0;

  void _setSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    context.read<DashboardBloc>().add(DashboardRequested());

    super.initState();
  }

  static const List<Widget> _pages = [
    HomePage(),
    Text("Chat Page"),
    Text("Notifications"),
    AccountPage()
  ];

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            CustomAppBar(
                height: double.infinity,
                appBar: AppBar(
                  elevation: 0,
                )),
            Container(
              margin: const EdgeInsets.only(top: 250),
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.tertiary,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
            ),
            _pages[_selectedIndex]
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          currentIndex: _selectedIndex,
          onTap: _setSelectedIndex,
          items: [
            BottomNavigationBarItem(
                activeIcon: const Icon(Icons.home_filled),
                icon: Icon(
                  Icons.home_outlined,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                label: locale.home),
            BottomNavigationBarItem(
                activeIcon: const Icon(Icons.chat_bubble),
                icon: Icon(
                  Icons.chat_bubble_outline,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                label: locale.chat),
            BottomNavigationBarItem(
                activeIcon: const Icon(Icons.notifications),
                icon: Icon(
                  Icons.notifications_outlined,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                label: locale.notifications),
            BottomNavigationBarItem(
                activeIcon: const Icon(Icons.account_circle),
                icon: Icon(
                  Icons.account_circle_outlined,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
                label: locale.account)
          ]),
    );
  }
}
