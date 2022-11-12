import 'package:flutter/material.dart';
import 'package:waaiburg_app/ui/navigation/app_route_path.dart';

// Parses the route/navigation information between AppRoutePath and RouteInformation
class AppRouteInformationParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);
    if (uri.pathSegments.isEmpty) {
      return MenuPageConfig;
    }

    final path = '/' + uri.pathSegments[0];
    switch (path) {
      case MenuPath:
        return MenuPageConfig;
      case LoginPath:
        return LoginPageConfig;
      case OptiesPath:
        return OptiesPageConfig;
      case NieuwtjesPath:
        return NieuwtjesPageConfig;
      case ArticlePath:
        return ArticlePageConfig;
      case VolwassenenPath:
        return VolwassenenPageConfig;
      case JongerenPath:
        return JongerenPageConfig;
      case WachtwoordVergetenPath:
        return WachtwoordVergetenPageConfig;
      case InformationBlockDetailPath:
        return InformationBlockDetailPageConfig;
      case InformationBlockListPath:
        return InformationBlockListPageConfig;
      case IngelogdMenuPath:
        return IngelogdMenuPageConfig;
      case BegeleidersPath:
        return BegeleidersPageConfig;
      case MijnGegevensPath:
        return MijnGegevensPageConfig;
      case ComingSoonPath:
        return ComingSoonPageConfig;
      default:
        return MenuPageConfig;
    }
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    switch (configuration.page) {
      case Pages.Menu:
        return const RouteInformation(location: MenuPath);
      case Pages.Login:
        return const RouteInformation(location: LoginPath);
      case Pages.Opties:
        return const RouteInformation(location: OptiesPath);
      case Pages.Nieuwtjes:
        return const RouteInformation(location: NieuwtjesPath);
      case Pages.Article:
        return const RouteInformation(location: ArticlePath);
      case Pages.Volwassenen:
        return const RouteInformation(location: VolwassenenPath);
      case Pages.Jongeren:
        return const RouteInformation(location: JongerenPath);
      case Pages.WachtwoordVergeten:
        return const RouteInformation(location: WachtwoordVergetenPath);
      case Pages.InformationBlockDetail:
        return const RouteInformation(location: InformationBlockDetailPath);
      case Pages.InformationBlockList:
        return const RouteInformation(location: InformationBlockListPath);
      case Pages.IngelogdMenu:
        return const RouteInformation(location: IngelogdMenuPath);
      case Pages.Begeleiders:
        return const RouteInformation(location: BegeleidersPath);
      case Pages.MijnGegevens:
        return const RouteInformation(location: MijnGegevensPath);
      case Pages.ComingSoon:
        return const RouteInformation(location: ComingSoonPath);
      default: return const RouteInformation(location: MenuPath);
    }
  }
}

