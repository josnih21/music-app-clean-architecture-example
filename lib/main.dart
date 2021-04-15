import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'injection_container.dart' as dependecyInjector;

Future main() async {
  await dependecyInjector.init();
  await DotEnv.load(fileName: ".env");
}
