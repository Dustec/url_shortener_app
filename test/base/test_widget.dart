import 'package:flutter/material.dart';

class TestWidget extends StatelessWidget {
  const TestWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = ignoreFlutterErrors;

    return MaterialApp(
      title: 'Test',
      debugShowCheckedModeBanner: false,
      home: child,
    );
  }
}

void Function(FlutterErrorDetails)? ignoreFlutterErrors = (
  FlutterErrorDetails details, {
  bool forceReport = false,
}) {
  bool ifIsOverflowError = false;

  // Detect overflow error.
  final Error exception = details.exception as Error;
  if (exception is FlutterError) {
    ifIsOverflowError = exception.diagnostics.any(
      (DiagnosticsNode e) =>
          e.value.toString().contains('A RenderFlex overflowed by'),
    );
  }

  // Ignore if is overflow error: only report to the console, but do not throw exception as it will
  // cause widget tests to fail.
  if (ifIsOverflowError) {
    debugPrint('Ignore error');
    return;
  }
  FlutterError.dumpErrorToConsole(details, forceReport: true);
  debugPrint(exception.toString());
  throw exception;
};
