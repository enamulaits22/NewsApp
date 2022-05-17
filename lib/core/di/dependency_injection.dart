import 'package:get_it/get_it.dart';

import '../network/http_client.dart';

GetIt sl = GetIt.instance;

void setup() {
  sl.registerSingleton(BaseHttpClient());
}
