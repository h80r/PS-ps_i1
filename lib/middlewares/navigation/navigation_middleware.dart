import 'package:redux/redux.dart';

import 'package:ps_i1/keys.dart';
import 'package:ps_i1/store/app_state.dart';

import 'package:ps_i1/middlewares/navigation/navigation_actions.dart';

/// Middleware para realizar a navegação
/// do aplicativo através de rotas.
class NavigationMiddleware extends MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) {
    final currentState = Keys.navigationKey.currentState;
    if (action is NavigateTo && currentState != null) {
      currentState.pushNamed(action.routeName);
    } else if (action is NavigateReplace && currentState != null) {
      currentState.pushReplacementNamed(action.routeName);
    } else if (action is NavigateBack && currentState != null) {
      currentState.pop();
    }
    next(action);
  }
}
