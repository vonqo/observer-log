# Observer Log :eyes:

Daily logger. 

## Log Format
Format: ```obs_YYYY-MM-DD.log``` Regex: ```'obs_[0-9]{1,4}_[0-9]{1,2}_[0-9]{1,2}.log'```

## Usage

Initialize log config before ```runApp```. And make sure ```WidgetsFlutterBinding.ensureInitialized()``` is placed on top of the main function.
```dart
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  String logPath = join(appDocumentsDir.path, 'logs/');
  
  Ob.applyConfig(
    path: logPath, // Log store path
    limit: 5       // How many days or how many log files should be kept?
  );
  
  runApp(const MyApp());
}
```

### Logging
```dart
Ob.log("Example of log lorem ipsum");
```

### Retrieving files
```dart
List<ObFile> files = await Ob.listFiles();

for(ObFile file in files) {
  print(file.toString());
}
```

## Credits

Enkh-Amar.G (vonqo)