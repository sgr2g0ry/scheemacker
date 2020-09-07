
class ElementModel {
  dynamic yaml;

  ElementModel({
    this.yaml,
  });

  static ElementModel fromYaml(dynamic elt) {
    return new ElementModel(
      yaml: elt
    );
  }

  String getId() {
    return yaml["id"].toString();
  }

  String getVersion() {
    return yaml["version"].toString();
  }

  String getKey() {
    return yaml["key"].toString();
  }

  String getText() {
    return yaml["text"].toString();
  }

  String getUrl() {
    return yaml["url"].toString();
  }
}