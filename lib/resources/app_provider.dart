import 'dart:async';
import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';
import 'package:scheemacker/models/app_model.dart';

class AppProvider {

  Future<AppModel> fetchApp() async {
    var yaml = loadYaml(await rootBundle.loadString("assets/app.yaml"));
    return AppModel.fromYaml(yaml);
  }

}