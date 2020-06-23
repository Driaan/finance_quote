// Copyright 2019 Ismael Jiménez. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:logger/logger.dart';

class AppLogger extends LogPrinter {
  final String className;

  AppLogger(this.className);

  @override
  List<String> log(LogEvent event) {
    final String emoji = PrettyPrinter.levelEmojis[event.level];
    if (event.error != null) {
      return [
        '$emoji${event.level} - [$className] ${event.message} ${event.error} ${event.stackTrace}'
      ];
    } else {
      return ['$emoji${event.level} - [$className] ${event.message}'];
    }
  }
}
