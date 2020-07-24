import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:flutter/cupertino.dart';

final dylib = DynamicLibrary.open("./libcpu_tuner.so");

class Result extends Struct {
  Pointer<Void> ok;
  Pointer<Utf8> err;
}

class TurboRatioLimits extends Struct {
  @Uint8()
  int ratio1CoresActive;
  @Uint8()
  int ratio2CoresActive;
  @Uint8()
  int ratio3CoresActive;
  @Uint8()
  int ratio4CoresActive;

  factory TurboRatioLimits.allocate(
          int ratio1CoresActive,
          int ratio2CoresActive,
          int ratio3CoresActive,
          int ratio4CoresActive) =>
      allocate<TurboRatioLimits>().ref
        ..ratio1CoresActive = ratio1CoresActive
        ..ratio2CoresActive = ratio2CoresActive
        ..ratio3CoresActive = ratio3CoresActive
        ..ratio4CoresActive = ratio4CoresActive;
}

typedef ffi_get_turbo_ratio_limits = Pointer<Result> Function();
typedef ffi_set_turbo_ratio_limits = Void Function(Pointer<TurboRatioLimits>);
typedef dart_set_turbo_ratio_limits = void Function(Pointer<TurboRatioLimits>);

final ffiGetTurboRatioLimits = dylib
    .lookup<NativeFunction<ffi_get_turbo_ratio_limits>>(
        'ffi_get_turbo_ratio_limits')
    .asFunction<ffi_get_turbo_ratio_limits>();
final ffiSetTurboRatioLimits = dylib
    .lookup<NativeFunction<ffi_set_turbo_ratio_limits>>(
        'ffi_set_turbo_ratio_limits')
    .asFunction<dart_set_turbo_ratio_limits>();

TurboRatioLimits getTurboRatioLimits() {
  var result = ffiGetTurboRatioLimits();
  if (result.ref.err != nullptr) {
    throw Utf8.fromUtf8(result.ref.err).trim();
  }
  return result.ref.ok.cast<TurboRatioLimits>().ref;
}

void setTurboRatioLimits(TurboRatioLimits turboRatioLimits) {
  debugPrint(turboRatioLimits.addressOf.toString());
  ffiSetTurboRatioLimits(turboRatioLimits.addressOf);
}
