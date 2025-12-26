import 'dart:io';

import 'package:flutter/material.dart';

ValueNotifier<bool> isMobile = ValueNotifier<bool>(Platform.isAndroid);
