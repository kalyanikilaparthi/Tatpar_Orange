import 'package:djangoflow_app/djangoflow_app.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tatpar_orange/configurations/configurations.dart';
import 'package:tatpar_orange/features/authentication/blocs/auth_cubit.dart';
import 'package:tatpar_orange/features/case/blocs/case_cubit.dart';
import 'package:tatpar_orange/features/home/presentation/widgets/app_bar_action.dart';

@RoutePage()
class AppHomePage extends StatelessWidget implements AutoRouteWrapper {
  const AppHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        CasesRoute(),
        //  TasksRoute(),
        ProfileRoute(),
        SettingsRoute(),
      ],
      transitionBuilder: (context, child, animation) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.fastOutSlowIn;

        if ((context.tabsRouter.previousIndex ?? 0) < context.tabsRouter.activeIndex) {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: begin, end: end).chain(
                CurveTween(
                  curve: curve,
                ),
              ),
            ),
            child: child,
          );
        } else {
          return SlideTransition(
            position: animation.drive(
              Tween(begin: -begin, end: -end).chain(
                CurveTween(curve: curve),
              ),
            ),
            child: child,
          );
        }
      },
      animationCurve: Curves.easeInOut,
      resizeToAvoidBottomInset: false,
      appBarBuilder: (context, tabsRouter) {
        final activeIndex = tabsRouter.activeIndex;

        return AppBar(
          title: activeIndex == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome ',
                      style: AppTextStyle.titleLarge.copyWith(
                        fontSize: 20,
                        height: 1.8,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      context.watch<AuthCubit>().state.user?.firstName ?? '',
                      style: AppTextStyle.titleSmall.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              : activeIndex == 2
                  ? Text(
                      'Profile',
                      style: AppTextStyle.titleLarge.copyWith(
                        fontSize: 20,
                        height: 1.8,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  : const Offstage(),
          actions: [
            AppBarAction(
              icon: Icons.sync,
              onclick: () async {
                final result = await context.read<CaseCubit>().pushLocalData();
                if (!result) {
                  DjangoflowAppSnackbar.showInfo('No Offline Data available to sync');
                }
              },
            ),
            const SizedBox(
              width: kPadding,
            ),
            AppBarAction(
              icon: Icons.logout,
              onclick: () {
                showDialog(
                  context: context,
                  builder: (context) => SizedBox(
                    width: kPadding * 40,
                    height: kPadding * 50,
                    child: AlertDialog(
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        const SizedBox(height: kPadding),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            context.read<AuthCubit>().logout();
                          },
                          child: const Text('Yes'),
                        ),
                      ],
                      title: const Text('Are you sure you want to logout?'),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              width: kPadding,
            ),
          ],
        );
      },
      bottomNavigationBuilder: (context, tabsRouter) {
        final activeIndex = tabsRouter.activeIndex;
        return SafeArea(
          bottom: true,
          child: Theme(
            data: Theme.of(context).copyWith(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              onTap: (value) {
                // if (value > 1) {
                //   DjangoflowAppSnackbar.showInfo('Coming Soon');
                // }
                tabsRouter.setActiveIndex(value);
              },
              currentIndex: activeIndex,
              type: BottomNavigationBarType.fixed,
              items: [
                _BottomNavBarItem(
                  icon: activeIndex == 0 ? CupertinoIcons.house_fill : CupertinoIcons.house,
                  label: 'Home',
                ),
                _BottomNavBarItem(
                  icon: activeIndex == 1 ? CupertinoIcons.doc_text_fill : CupertinoIcons.doc_text,
                  label: 'Cases',
                ),
                // _BottomNavBarItem(
                //   icon: activeIndex == 2
                //       ? Icons.more_horiz
                //       : Icons.more_horiz_outlined,
                //   label: 'Tasks',
                // ),
                _BottomNavBarItem(
                  icon: activeIndex == 2 ? CupertinoIcons.person_fill : CupertinoIcons.person,
                  label: 'Profile',
                ),
                _BottomNavBarItem(
                  icon: activeIndex == 3 ? CupertinoIcons.settings_solid : CupertinoIcons.settings,
                  label: 'Settings',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) => this;
}

class _BottomNavBarItem extends BottomNavigationBarItem {
  _BottomNavBarItem({
    required String label,
    required IconData icon,
  }) : super(
          label: label,
          icon: Padding(
            padding: const EdgeInsets.all(kPadding),
            child: Icon(
              icon,
            ),
          ),
        );
}
