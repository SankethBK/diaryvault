import 'package:logger/logger.dart';

class CustomPrinter extends LogPrinter {
  final String? className;

  CustomPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.levelColors[event.level];
    final emoji = PrettyPrinter.levelEmojis[event.level];
    final message = event.message;

    return [color!('$emoji $className: $message')];
  }
}

Logger printer([String? className]) {
  return Logger(printer: CustomPrinter(className));
}
