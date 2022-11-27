import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:waaiburg_app/ui/view/article_view.dart';
import 'package:waaiburg_app/ui/view/coming_soon_view.dart';
import 'package:waaiburg_app/ui/view/information_block_detail_view.dart';
import 'package:waaiburg_app/ui/view/information_block_list_view.dart';
import 'package:waaiburg_app/ui/view/jongeren_view.dart';
import 'package:waaiburg_app/ui/view/menu_view.dart';
import 'package:waaiburg_app/ui/view/nieuwtjes_view.dart';
import 'package:waaiburg_app/ui/view/opties_view.dart';
import 'package:waaiburg_app/ui/view/volwassenen_view.dart';
import 'package:waaiburg_app/ui/view/login_view.dart';  
import 'package:waaiburg_app/ui/view/wachtwoord_vergeten_view.dart';
import 'package:waaiburg_app/ui/view/ingelogd_menu_view.dart';
import 'package:waaiburg_app/ui/view/begeleiders_view.dart';
import 'package:waaiburg_app/ui/view/mijn_gegevens_view.dart';

import 'package:waaiburg_app/ui/navigation/app_route_path.dart';
import 'package:waaiburg_app/app_state.dart';
import 'package:waaiburg_app/ui/navigation/back_dispatcher.dart';

class AppRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  final List<Page> _pages = [];
  AppBackButtonDispatcher backButtonDispatcher;

  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final AppState appState;

  AppRouterDelegate(this.appState) : navigatorKey = GlobalKey() {
    appState.addListener(() {
      notifyListeners();
    });
  }

  /// Getter for a list that cannot be changed
  List<MaterialPage> get pages => List.unmodifiable(_pages);

  /// Number of pages function
  int numPages() => _pages.length;

  @override
  PageConfiguration get currentConfiguration =>
      _pages.last.arguments as PageConfiguration;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopPage,
      pages: buildPages(),
    );
  }

  bool _onPopPage(Route<dynamic> route, result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      print("did not pop: false");
      return false;
    }
    if (canPop()) {
      pop();
      print("did pop: true");
      return true;
    } else {
      return false;
    }
  }

  void _removePage(MaterialPage page) {
    if (page != null) {
      _pages.remove(page);
    }
  }

  void pop() {
    if (canPop()) {
      _removePage(_pages.last);
    } else {
      final message = 'test';
      Fluttertoast.showToast(msg: message, fontSize: 18);
    }
  }

  bool canPop() {
    return _pages.length > 1;
  }

  @override
  Future<bool> popRoute() {
    if (canPop()) {
      _removePage(_pages.last);
      return Future.value(true);
    }
    return Future.value(false);
  }

  MaterialPage _createPage(Widget child, PageConfiguration pageConfig) {
    return MaterialPage(
        child: child,
        key: ValueKey(pageConfig.key),
        name: pageConfig.path,
        arguments: pageConfig);
  }

  void _addPageData(Widget child, PageConfiguration pageConfig) {
    _pages.add(
      _createPage(child, pageConfig),
    );
  }

  void addPage(PageConfiguration pageConfig) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).page != pageConfig.page;
    if (shouldAddPage) {
      switch (pageConfig.page) {
        case Pages.Menu:
          _addPageData(MenuView(), MenuPageConfig);
          break;
        case Pages.Login:
          _addPageData(LoginView(), LoginPageConfig);
          break;
        case Pages.Opties:
          _addPageData(OptiesView(), OptiesPageConfig);
          break;
        case Pages.Nieuwtjes:
          _addPageData(NieuwtjesView(), NieuwtjesPageConfig);
          break;
        case Pages.Article:
          _addPageData(ArticleView(), ArticlePageConfig);
          break;
        case Pages.Volwassenen:
          _addPageData(VolwassenenView(), VolwassenenPageConfig);
          break;
        case Pages.Jongeren:
          _addPageData(JongerenView(), JongerenPageConfig);
          break;
        case Pages.WachtwoordVergeten:
          _addPageData(WachtwoordVergetenView(), WachtwoordVergetenPageConfig);
          break;
        case Pages.InformationBlockDetail:
          _addPageData(
              InformationBlockDetailView(), InformationBlockDetailPageConfig);
          break;
        case Pages.InformationBlockList:
          _addPageData(
              InformationBlockListView(), InformationBlockListPageConfig);
          break;
        case Pages.IngelogdMenu:
          _addPageData(IngelogdMenuView(), IngelogdMenuPageConfig);
          break;
        case Pages.Begeleiders:
          _addPageData(BegeleidersView(), BegeleidersPageConfig);
          break;
        case Pages.MijnGegevens:
          _addPageData(MijnGegevensView(), MijnGegevensPageConfig);
          break;
        case Pages.ComingSoon:
          _addPageData(ComingSoonView(), ComingSoonPageConfig);
          break;
        default:
          break;
      }
    }
  }

  void replace(PageConfiguration newRoute) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    addPage(newRoute);
  }

  void setPath(List<MaterialPage> path) {
    _pages.clear();
    _pages.addAll(path);
  }

  void replaceAll(PageConfiguration newRoute) {
    setNewRoutePath(newRoute);
  }

  void push(PageConfiguration newRoute) {
    addPage(newRoute);
  }

  void pushWidget(Widget child, PageConfiguration newRoute) {
    _addPageData(child, newRoute);
  }

  void addAll(List<PageConfiguration> routes) {
    _pages.clear();
    routes.forEach((route) {
      addPage(route);
    });
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).page != configuration.page;
    if (shouldAddPage) {
      _pages.clear();
      addPage(configuration);
    }
    return SynchronousFuture(null);
  }

  void _setPageAction(PageAction action) {
    switch (action.page.page) {
      case Pages.Menu:
        MenuPageConfig.currentPageAction = action;
        break;
      case Pages.Login:
        LoginPageConfig.currentPageAction = action;
        break;
      case Pages.Opties:
        OptiesPageConfig.currentPageAction = action;
        break;
      case Pages.Nieuwtjes:
        NieuwtjesPageConfig.currentPageAction = action;
        break;
      case Pages.Article:
        ArticlePageConfig.currentPageAction = action;
        break;
      case Pages.Volwassenen:
        VolwassenenPageConfig.currentPageAction = action;
        break;
      case Pages.Jongeren:
        JongerenPageConfig.currentPageAction = action;
        break;
      case Pages.WachtwoordVergeten:
        WachtwoordVergetenPageConfig.currentPageAction = action;
        break;
      case Pages.InformationBlockDetail:
        InformationBlockDetailPageConfig.currentPageAction = action;
        break;
      case Pages.IngelogdMenu:
        IngelogdMenuPageConfig.currentPageAction = action;
        break;
      case Pages.Begeleiders:
        BegeleidersPageConfig.currentPageAction = action;
        break;
      case Pages.MijnGegevens:
        MijnGegevensPageConfig.currentPageAction = action;
        break;
      case Pages.ComingSoon:
        ComingSoonPageConfig.currentPageAction = action;
        break;
      default:
        break;
    }
  }

  List<Page> buildPages() {
    switch (appState.currentAction.state) {
      case PageState.none:
        break;
      case PageState.addPage:
        _setPageAction(appState.currentAction);
        addPage(appState.currentAction.page);
        break;
      case PageState.pop:
        pop();
        break;
      case PageState.replace:
        _setPageAction(appState.currentAction);
        replace(appState.currentAction.page);
        break;
      case PageState.replaceAll:
        _setPageAction(appState.currentAction);
        replaceAll(appState.currentAction.page);
        break;
      case PageState.addWidget:
        _setPageAction(appState.currentAction);
        pushWidget(appState.currentAction.widget, appState.currentAction.page);
        break;
      case PageState.addAll:
        addAll(appState.currentAction.pages);
        break;
    }

    appState.resetCurrentAction();
    return List.of(_pages);
  }
}
