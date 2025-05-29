# Bank Card Widget

A customizable and reusable bank card widget for Flutter with various styling options.

[![pub package](https://img.shields.io/pub/v/bank_card_widget.svg)](https://pub.dev/packages/bank_card_widget)

## Screenshots

![Demo Cards](https://raw.githubusercontent.com/danial2026/bank_card_widget/main/assets/demo.png)

## Features

- **Customizable Appearance** - Easily customize colors, fonts, and layout.
- **Responsive Design** - Adapts to different screen sizes (Note: Current implementation uses fixed size, will be improved).
- **Flexible Styling** - Use the `BankCardStyle` class for comprehensive styling.

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  bank_card_widget: any
```

Then run:

```bash
flutter pub get
```

## Usage

### Basic Usage

```dart
import 'package:bank_card_widget/bank_card_widget.dart';

BankCardWidget(
  cardNumber: '1234 5678 9010 1234',
  cardHolderName: 'JOHN DOE',
  expiryDate: '12/24',
  cvv: '123',
  cardColor: Colors.blue.shade700,
  textColor: Colors.white,
)
```

### Using Modal Bottom Sheet

```dart
import 'package:bank_card_widget/bank_card_widget.dart';

void _showBankCard() {
  showBankCardWidget(
    context: context,
    cardNumber: '1234 5678 9010 1234',
    cardHolderName: 'JOHN DOE',
    expiryDate: '12/24',
    cvv: '123',
    cardColor: Theme.of(context).brightness == Brightness.dark ? Colors.black87 : Colors.blue.shade700,
    textColor: Colors.white,
  );
}
```

### Custom Styling

```dart
import 'package:bank_card_widget/bank_card_widget.dart';

BankCardWidget(
  cardNumber: '5678 1234 9010 1234',
  cardHolderName: 'JANE SMITH',
  expiryDate: '10/25',
  cvv: '456',
  cardColor: Colors.green.shade700,
  textColor: Colors.white,
  style: BankCardStyle(
    cornerRadius: 10.0,
    cardNumberTextStyle: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.normal,
      letterSpacing: 3.0,
      color: Colors.yellowAccent,
    ),
  ),
)
```

See the example app for more styling options.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
