import 'package:flutter/cupertino.dart';
import 'package:waaiburg_app/app_state.dart';

const String MenuPath = '/menu';
const String LoginPath = '/login';
const String OptiesPath = '/opties';
const String NieuwtjesPath = '/nieuwtjes';
const String ArticlePath = '/article';
const String VolwassenenPath = '/volwassenen';
const String JongerenPath = '/jongeren';
const String WachtwoordVergetenPath = '/wachtwoordVergeten';
const String InformationBlockDetailPath = '/informationBlockDetail';
const String InformationBlockListPath = '/informationBlockList';
const String IngelogdMenuPath = '/ingelogdMenu';
const String BegeleidersPath = '/begeleiders';
const String MijnGegevensPath = '/mijnGegevens';
const String ComingSoonPath = "/comingSoon";

enum Pages {
  Menu,
  Login,
  Opties,
  Nieuwtjes,
  Article,
  Volwassenen,
  Jongeren,
  WachtwoordVergeten,
  InformationBlockDetail,
  InformationBlockList,
  IngelogdMenu,
  Begeleiders,
  MijnGegevens,
  ComingSoon
}

class PageConfiguration {
  final String key;
  final String path;
  final Pages page;
  PageAction currentPageAction;

  PageConfiguration(
      {@required this.key,
      @required this.path,
      @required this.page,
      this.currentPageAction});
}

PageConfiguration MenuPageConfig = PageConfiguration(
    key: 'Menu', path: MenuPath, page: Pages.Menu, currentPageAction: null);
PageConfiguration LoginPageConfig = PageConfiguration(
    key: 'Login', path: LoginPath, page: Pages.Login, currentPageAction: null);
PageConfiguration OptiesPageConfig = PageConfiguration(
    key: 'Opties',
    path: OptiesPath,
    page: Pages.Opties,
    currentPageAction: null);
PageConfiguration NieuwtjesPageConfig = PageConfiguration(
    key: 'Nieuwtjes',
    path: NieuwtjesPath,
    page: Pages.Nieuwtjes,
    currentPageAction: null);
PageConfiguration ArticlePageConfig = PageConfiguration(
    key: 'Article',
    path: ArticlePath,
    page: Pages.Article,
    currentPageAction: null);
PageConfiguration VolwassenenPageConfig = PageConfiguration(
    key: 'Volwassenen',
    path: VolwassenenPath,
    page: Pages.Volwassenen,
    currentPageAction: null);
PageConfiguration JongerenPageConfig = PageConfiguration(
    key: 'Jongeren',
    path: JongerenPath,
    page: Pages.Jongeren,
    currentPageAction: null);
PageConfiguration WachtwoordVergetenPageConfig = PageConfiguration(
    key: 'WachtwoordVergeten',
    path: WachtwoordVergetenPath,
    page: Pages.WachtwoordVergeten,
    currentPageAction: null);
PageConfiguration InformationBlockDetailPageConfig = PageConfiguration(
    key: 'InformationBlockDetail',
    path: InformationBlockDetailPath,
    page: Pages.InformationBlockDetail,
    currentPageAction: null);
PageConfiguration InformationBlockListPageConfig = PageConfiguration(
    key: 'InformationBlockList',
    path: InformationBlockListPath,
    page: Pages.InformationBlockList,
    currentPageAction: null);
PageConfiguration IngelogdMenuPageConfig = PageConfiguration(
    key: 'IngelogdMenu',
    path: IngelogdMenuPath,
    page: Pages.IngelogdMenu,
    currentPageAction: null);
PageConfiguration BegeleidersPageConfig = PageConfiguration(
    key: 'Begeleiders',
    path: BegeleidersPath,
    page: Pages.Begeleiders,
    currentPageAction: null);
PageConfiguration MijnGegevensPageConfig = PageConfiguration(
    key: 'MijnGegevens',
    path: MijnGegevensPath,
    page: Pages.MijnGegevens,
    currentPageAction: null);
PageConfiguration ComingSoonPageConfig = PageConfiguration(
    key: 'ComingSoon',
    path: ComingSoonPath,
    page: Pages.ComingSoon,
    currentPageAction: null);
