import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/v4.dart';

import 'snacks.dart';

export 'snacks.dart';

enum SnackAction {
  add,
  remove;

  const SnackAction();

  bool get adding => this == SnackAction.add;

  bool get removing => this == SnackAction.remove;
}

class SnackMessage {
  final AppSnack snack;
  final SnackAction action;

  SnackMessage(
    this.snack,
    this.action,
  );

  bool get adding => action.adding;

  bool get removing => action.removing;
}

class SnackBarCubit extends Cubit<List<AppSnack>> {
  SnackBarCubit() : super([]);

  Map<String, Timer> cancelTokens = {};

  final StreamController<SnackMessage> snacksController =
      StreamController.broadcast();

  void push(AppSnack snack) {
    snack = snack.copyWith(index: const UuidV4().generate());
    emit([...state, snack]);
    snacksController.add(SnackMessage(snack, SnackAction.add));
    cancelTokens[snack.index!] = Timer(snack.duration,
        () => snacksController.add(SnackMessage(snack, SnackAction.remove)));
  }

  void remove(AppSnack snack) {
    if (cancelTokens.containsKey(snack.index)) {
      cancelTokens[snack.index]?.cancel();
      cancelTokens.remove(snack.index);
    }
    state.remove(snack);
    emit(state);
    snacksController.add(SnackMessage(snack, SnackAction.remove));
  }
}
