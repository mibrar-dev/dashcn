// Unit tests for [ButtonStatusController] (P7-S1): the uncontrolled status
// machine without widgets. Reset timing uses short real durations.

import 'dart:async';

import 'package:dashcn/src/components/button/button.dart';
import 'package:flutter_test/flutter_test.dart';

const Duration _reset = Duration(milliseconds: 60);

void main() {
  test('run moves loading -> success -> idle after the reset delay', () async {
    final ButtonStatusController controller = ButtonStatusController(
      resetDuration: _reset,
    );
    final List<ButtonStatus> seen = <ButtonStatus>[];
    controller.addListener(() => seen.add(controller.status));
    final Completer<void> gate = Completer<void>();
    final Future<void> run = controller.run(() => gate.future);
    expect(controller.status, ButtonStatus.loading);
    gate.complete();
    await run;
    expect(controller.status, ButtonStatus.success);
    expect(seen, <ButtonStatus>[ButtonStatus.loading, ButtonStatus.success]);
    await Future<void>.delayed(_reset * 2);
    expect(controller.status, ButtonStatus.idle);
    expect(seen.last, ButtonStatus.idle);
    controller.dispose();
  });

  test('a throw moves to failure and reports through onError', () async {
    final ButtonStatusController controller = ButtonStatusController(
      resetDuration: _reset,
    );
    final List<Object> errors = <Object>[];
    controller.onError = (Object error, StackTrace _) => errors.add(error);
    final Completer<void> gate = Completer<void>();
    final Future<void> run = controller.run(() => gate.future);
    gate.completeError(StateError('Nope.'));
    await run;
    expect(controller.status, ButtonStatus.failure);
    expect(errors, hasLength(1));
    expect(errors.single, isStateError);
    await Future<void>.delayed(_reset * 2);
    expect(controller.status, ButtonStatus.idle);
    controller.dispose();
  });

  test('null reset duration stays on the end state', () async {
    final ButtonStatusController controller = ButtonStatusController(
      resetDuration: null,
    );
    final Completer<void> gate = Completer<void>();
    final Future<void> run = controller.run(() => gate.future);
    gate.complete();
    await run;
    await Future<void>.delayed(_reset * 2);
    expect(controller.status, ButtonStatus.success);
    controller.dispose();
  });

  test('re-entrant run while loading is ignored', () async {
    final ButtonStatusController controller = ButtonStatusController(
      resetDuration: _reset,
    );
    final Completer<void> first = Completer<void>();
    final Completer<void> second = Completer<void>();
    var secondStarted = false;
    final Future<void> run = controller.run(() => first.future);
    await controller.run(() {
      secondStarted = true;
      return second.future;
    });
    expect(secondStarted, isFalse);
    first.complete();
    await run;
    expect(controller.status, ButtonStatus.success);
    controller.dispose();
  });

  test('a new run cancels a pending reset', () async {
    final ButtonStatusController controller = ButtonStatusController(
      resetDuration: _reset,
    );
    final Completer<void> first = Completer<void>();
    final Completer<void> second = Completer<void>();
    unawaited(controller.run(() => first.future));
    first.complete();
    await first.future;
    expect(controller.status, ButtonStatus.success);
    await Future<void>.delayed(_reset ~/ 2);
    final Future<void> rerun = controller.run(() => second.future);
    expect(controller.status, ButtonStatus.loading);
    second.complete();
    await rerun;
    expect(controller.status, ButtonStatus.success);
    // The first reset (armed before the rerun) must not fire early.
    await Future<void>.delayed(_reset ~/ 2 + const Duration(milliseconds: 5));
    expect(controller.status, ButtonStatus.success);
    await Future<void>.delayed(_reset);
    expect(controller.status, ButtonStatus.idle);
    controller.dispose();
  });

  test('reset returns to idle immediately', () async {
    final ButtonStatusController controller = ButtonStatusController(
      resetDuration: _reset,
    );
    final Completer<void> gate = Completer<void>();
    final Future<void> run = controller.run(() => gate.future);
    gate.complete();
    await run;
    controller.reset();
    expect(controller.status, ButtonStatus.idle);
    await Future<void>.delayed(_reset * 2);
    expect(controller.status, ButtonStatus.idle);
    controller.dispose();
  });
}
