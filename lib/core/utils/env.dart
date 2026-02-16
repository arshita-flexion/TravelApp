// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

String get DEV_SERVER_BASEURL => dotenv.env['DEV_SERVER_BASEURL'] ?? '';
String get PROD_SERVER_BASEURL => dotenv.env['PROD_SERVER_BASEURL'] ?? '';
String get STAGE_SERVER_BASEURL => dotenv.env['STAGE_SERVER_BASEURL'] ?? '';
String get GOOGLE_SERVER_CLIENT_ID => dotenv.env['GOOGLE_SERVER_CLIENT_ID'] ?? '';
