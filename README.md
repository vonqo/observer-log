# Observer Log

Event logger based on system day. Simple and easy to extract.

## Usage

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Directory appDocumentsDir = await getApplicationDocumentsDirectory();
  Ob.applyConfig(
      path: '${appDocumentsDir.path}/logs/', // log store directory
      limit: 5 
  );
  
  runApp(const MyApp());
}
```

```dart
Ob.log("Example of log lorem ipsum");
```

## Credits

Enkh-Amar.G (vonqo)