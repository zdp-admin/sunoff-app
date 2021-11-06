import 'package:flutter/material.dart';
import 'package:sunoff/models/cotizacion/cotizacion_model.dart';
import 'package:sunoff/pages/category-film/category_film_page.dart';
import 'package:sunoff/pages/comentary/comentary_page.dart';
import 'package:sunoff/pages/cotizacion/cotizacion_page.dart';
import 'package:sunoff/pages/pricing-details/pricing_details_page.dart';
import 'package:sunoff/pages/new-pricing/new_pricing_page.dart';
import 'package:sunoff/pages/pricing/pricing_page.dart';
import 'package:sunoff/pages/installer/installer_page.dart';
import 'package:sunoff/pages/pelis-types/peli_types.dart';
import '../pages/login/login_page.dart';
import '../pages/profile/profile_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  /*return MaterialPageRoute(
      builder: (context) => CotizacionPage(), settings: settings);
*/
  switch (settings.name) {
    case 'login':
      return MaterialPageRoute(
          builder: (context) => LoginPage(), settings: settings);
    case 'profile':
      return MaterialPageRoute(
          builder: (context) => ProfilePage(), settings: settings);
    case 'account-status':
      return MaterialPageRoute(
          builder: (context) => PricingDetailsPage(
                cotization: CotizacionModel.fromJson({}),
              ),
          settings: settings);
    case 'pricing':
      return MaterialPageRoute(
          builder: (context) => PricingPage(), settings: settings);
    case 'peliculas':
      return MaterialPageRoute(
          builder: (context) => PeliPage(), settings: settings);
    case 'new-pricing':
      return MaterialPageRoute(
          builder: (context) => NewPricingPage(),
          //CotizacionPage(cotizacionModel: new CotizacionModel()),
          //ComentaryPage(cotizacionModel: new CotizacionModel()),
          settings: settings);
    case 'films-category':
      int categoryId = 0;

      if (settings.arguments is int) {
        categoryId = settings.arguments as int;
      }

      return MaterialPageRoute(
          builder: (context) => DecorativePage(
                categoryId: categoryId,
              ),
          settings: settings);
    case 'installer':
      return MaterialPageRoute(
          builder: (context) => InstallerPage(), settings: settings);
    case 'comentary-page':
      CotizacionModel cotizacion = CotizacionModel();

      if (settings.arguments is CotizacionModel) {
        cotizacion = settings.arguments as CotizacionModel;
      }
      return MaterialPageRoute(
          builder: (context) => ComentaryPage(
                cotizacionModel: cotizacion,
              ),
          settings: settings);
    /*case 'resume-page':
      ClientModel clientModel = ClientModel.fromJson({});

      if (settings.arguments is ClientModel) {
        clientModel = settings.arguments as ClientModel;
      }
      return MaterialPageRoute(
          builder: (context) => PricingDetailsPage(), settings: settings);*/
    case 'new-pricing-details':
      late CotizacionModel cotizacionModel;

      if (settings.arguments is CotizacionModel) {
        cotizacionModel = settings.arguments as CotizacionModel;
      }

      return MaterialPageRoute(
          builder: (context) =>
              new CotizacionPage(cotizacionModel: cotizacionModel),
          settings: settings);
    default:
      return MaterialPageRoute(
          builder: (context) => Container(), settings: settings);
  }
}
