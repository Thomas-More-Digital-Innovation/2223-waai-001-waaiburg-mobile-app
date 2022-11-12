abstract class BaseConfig {
  String get apiHost;
}

class DevConfig implements BaseConfig {
  String get apiHost => "waaiburgwebapp.sinners.be"; //waaiburg_website 
}

class ProdConfig implements BaseConfig {
  String get apiHost => "dewaaiburgapp.eu";
}
