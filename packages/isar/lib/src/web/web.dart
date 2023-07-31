// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:html';
import 'dart:js_util';
import 'dart:typed_data';

import 'package:isar/isar.dart';
import 'package:isar/src/web/interop.dart';

export 'bindings.dart';
export 'ffi.dart';
export 'interop.dart';

Future<R> scheduleIsolate<R>(R Function() callback, {String? debugName}) async {
  throw UnimplementedError();
}

FutureOr<IsarCoreBindings> initializePlatformBindings([
  String? libraryPath,
]) async {
  final url = libraryPath ?? 'https://unpkg.com/isar@${Isar.version}/isar.wasm';
  final w = window as JSWindow;
  final promise = w.WebAssembly.instantiateStreaming(
    w.fetch(url),
    jsify({'env': <String, String>{}}),
  );
  final wasm = await promiseToFuture<JSWasmModule>(promise);
  return wasm.instance.exports;
}

typedef IsarCoreBindings = JSIsar;

class ReceivePort extends Stream<void> {
  final sendPort = SendPort();

  @override
  StreamSubscription<void> listen(
    void Function(dynamic event)? onData, {
    Function? onError,
    void Function()? onDone,
    bool? cancelOnError,
  }) {
    throw UnimplementedError();
  }

  void close() {
    throw UnimplementedError();
  }
}

class SendPort {
  int get nativePort => 0;
}

int platformFastHash(String str) {
  var i = 0,
      t0 = 0,
      v0 = 0x2325,
      t1 = 0,
      v1 = 0x8422,
      t2 = 0,
      v2 = 0x9ce4,
      t3 = 0,
      v3 = 0xcbf2;

  while (i < str.length) {
    v0 ^= str.codeUnitAt(i++);
    t0 = v0 * 435;
    t1 = v1 * 435;
    t2 = v2 * 435;
    t3 = v3 * 435;
    t2 += v0 << 8;
    t3 += v1 << 8;
    t1 += t0 >>> 16;
    v0 = t0 & 65535;
    t2 += t1 >>> 16;
    v1 = t1 & 65535;
    v3 = (t3 + (t2 >>> 16)) & 65535;
    v2 = t2 & 65535;
  }

  return (v3 & 15) * 281474976710656 +
      v2 * 4294967296 +
      v1 * 65536 +
      (v0 ^ (v3 >> 4));
}
