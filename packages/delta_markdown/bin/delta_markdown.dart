// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:args/args.dart';
import 'package:delta_markdown/delta_markdown.dart';

Future main(List<String> args) async {
  final parser = ArgParser()
    ..addFlag('help', negatable: false, help: 'Print help text and exit')
    ..addFlag('version', negatable: false, help: 'Print version and exit')
    ..addOption('from',
        abbr: 'f', defaultsTo: 'markdown', allowed: ['markdown', 'delta']);
  final results = parser.parse(args);

  if (results['help'] as bool) {
    printUsage(parser);
    return;
  }

  if (results['version'] as bool) {
    print(version);
    return;
  }

  if (results.rest.length > 1) {
    printUsage(parser);
    exitCode = 1;
    return;
  }

  if (results.rest.length == 1) {
    // Read argument as a file path.
    final input = File(results.rest.first).readAsStringSync();
    if (results['from'] == 'delta') {
      print(deltaToMarkdown(input));
    } else {
      print(markdownToDelta(input));
    }
    return;
  }

  // Read from stdin.
  final buffer = StringBuffer();
  String? line;
  while ((line = stdin.readLineSync()) != null) {
    buffer.writeln(line);
  }
  if (results['from'] == 'delta') {
    print(deltaToMarkdown(buffer.toString()));
  } else {
    print(markdownToDelta(buffer.toString()));
  }
}

void printUsage(ArgParser parser) {
  print('''
Usage: delta_markdown.dart [options] [file]

Parse [file] as Markdown and print resulting Quill Delta. If [file] is omitted,
use stdin as input.

${parser.usage}
''');
}
