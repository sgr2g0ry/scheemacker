import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:scheemacker/models/app_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:scheemacker/blocs/home_bloc.dart';
import 'package:scheemacker/models/element_model.dart';

///
/// - META DONNEES
/// - PUT ON GIT
///

class HomeUI extends StatefulWidget {
  @override
  HomeUIState createState() => HomeUIState();
}

class HomeUIState extends State<HomeUI> {
  HomeBloc homeBloc = HomeBloc();
  AppModel app;

  @override
  initState() {
    super.initState();
    homeBloc.fetchApp();
  }

  @override
  dispose() {
    homeBloc.dispose();
    super.dispose();
  }

  //getElement(String number, String key, String text, Color color, String url) {
  getElement(ElementModel element) {
    Widget child = Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(element.getId(), style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
          )
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(element.getKey(), style: TextStyle(fontSize: 60, color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(element.getText(), style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
        )
      ],
    );

    return GestureDetector(
      onTap: () {
        _launchURL(element.getUrl());
      },
      child: Container (
        margin: EdgeInsets.all(10),
        child: child,
        height: 220,
        width: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 5,
            color: Colors.black
          ),
        ),
      ),
    );
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  getCopyright(String text) {
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Text(text),
    );
  }

  getApp(String version, String layout) {
    return Padding(
      padding: const EdgeInsets.only(top:20.0),
      child: Text("$version / $layout", style: TextStyle(fontSize: 10)),
    );
  }

  getTechnicalInfo(String text, String url) {
    return GestureDetector(
      onTap: () {
        _launchURL(url);
      },
      child: Padding(
        padding: const EdgeInsets.only(top:20.0),
        child: Text(text, style: TextStyle(fontSize: 10, color: Colors.blue)),
      )
    );
  }

  getDesktopBody() {
    return StreamBuilder(
        stream: homeBloc.app,
        builder: (BuildContext context, AsyncSnapshot<AppModel> snapshot) {
          Widget body = Center(child: CircularProgressIndicator());
          if (snapshot.hasData || app != null) {
            if (snapshot.hasData) app = snapshot.data;

            List<Widget> children = new List<Widget>();
            for (ElementModel element in app.getElements()) {
              children.add(getElement(element));
            }
            body = Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
                getCopyright(app.getCopyright()),
                getTechnicalInfo(app.getTechnicalInfoText(), app.getTechnicalInfoUrl()),
                getApp(app.getVersion(), "desktop"),
              ],
            );
          }
          return SingleChildScrollView(child: ConstrainedBox(child: body, constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height)));
        }
    );
  }

  getMobileBody() {
    return StreamBuilder(
        stream: homeBloc.app,
        builder: (BuildContext context, AsyncSnapshot<AppModel> snapshot) {
          Widget body = Center(child: CircularProgressIndicator());
          if (snapshot.hasData || app != null) {
            if (snapshot.hasData) app = snapshot.data;

            List<Widget> children = new List<Widget>();
            for (ElementModel element in app.getElements()) {
              children.add(getElement(element));
            }
            children.add(getCopyright(app.getCopyright()));
            children.add(getTechnicalInfo(app.getTechnicalInfoText(), app.getTechnicalInfoUrl()));
            children.add(getApp(app.getVersion(), "mobile"));
            body = Center(
              child: Column(children: children),
            );
          }
          return SingleChildScrollView(child: body);
        }
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget body = ScreenTypeLayout(
      mobile: getMobileBody(),
      tablet: getDesktopBody(),
      desktop: getDesktopBody(),
    );

    return Scaffold(
      body: body,
      backgroundColor: Colors.white,
    );

  }

}