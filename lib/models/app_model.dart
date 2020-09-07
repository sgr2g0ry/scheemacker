import 'package:scheemacker/models/element_model.dart';

class AppModel {
  dynamic yaml;

  AppModel({
    this.yaml,
  });

  static AppModel fromYaml(dynamic elt) {
    return new AppModel(
      yaml: elt
    );
  }

  String getVersion() {
    return yaml["version"].toString();
  }

  String getCopyright() {
    return yaml["copyright"].toString();
  }

  String getTechnicalInfoText() {
    return yaml["technicalInfo"]["text"].toString();
  }

  String getTechnicalInfoUrl() {
    return yaml["technicalInfo"]["url"].toString();
  }

  List<ElementModel> getElements() {
    List<ElementModel> elements = new List<ElementModel>();
    for (var i=0; i<yaml["elements"].length; i++) {
      elements.add(ElementModel.fromYaml(yaml["elements"][i]));
    }
    return elements;
  }
}