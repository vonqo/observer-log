# Observer Log :eyes:

Event logger based on system day. Simple and easy to extract.

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
      path: logPath,
      limit: 5 
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

// 
for(ObFile file in files) {
  print(file.toString());
}
```

## Credits

Enkh-Amar.G (vonqo)