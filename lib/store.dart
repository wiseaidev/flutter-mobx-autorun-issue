import 'package:mobx/mobx.dart';

// Include generated file
part 'store.g.dart';

// This is the class used by rest of your codebase
class AppState = _AppState with _$AppState;

// The store-class
abstract class _AppState with Store {
  @observable
  AppPage currentPage = AppPage.splash;

  @action
  void goTo(AppPage page) {
    currentPage = page;
  }

  @action
  Future<void> initialize() async {
    currentPage = AppPage.splash;
  }
}

enum AppPage { login, home, splash }
