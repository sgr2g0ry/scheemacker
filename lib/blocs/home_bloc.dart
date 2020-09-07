import 'package:rxdart/rxdart.dart';
import 'package:scheemacker/models/app_model.dart';
import 'package:scheemacker/resources/app_provider.dart';

class HomeBloc {
  final _appRepository = AppProvider();

  final _appFetcher = PublishSubject<AppModel>();

  Stream<AppModel> get app => _appFetcher.stream;

  fetchApp() async {
    try {
      AppModel value = await _appRepository.fetchApp();
      if (!_appFetcher.isClosed) _appFetcher.sink.add(value);
    } catch (e) {
      if (!_appFetcher.isClosed) _appFetcher.sink.addError(e);
    }
  }

  dispose() {
    _appFetcher.close();
  }
}