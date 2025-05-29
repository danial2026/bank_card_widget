import 'package:bank_card_widget_example/widgets/package_info_card.dart';
import 'package:flutter/material.dart';
import 'package:bank_card_widget/bank_card_widget.dart';

/// Main home page displaying all the time range sheet examples
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDarkMode = false;

  // Define the list of bank card examples
  List<Widget> get _bankCardExamples => [
        BankCardWidget(
          cardNumber: '4111 1111 1111 1111',
          cardHolderName: 'GRADIENT CARD',
          expiryDate: '11/27',
          cvv: '345',
          style: BankCardStyle.basic(
            textColor: Colors.white,
            cardGradient: const LinearGradient(
              colors: [Colors.purple, Colors.deepPurpleAccent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        BankCardWidget(
          cardNumber: '5555 5555 5555 5555',
          cardHolderName: 'ANOTHER GRADIENT',
          expiryDate: '05/28',
          cvv: '678',
          style: BankCardStyle.basic(
            textColor: Colors.black,
            cardGradient: const LinearGradient(
              colors: [Colors.yellow, Colors.orange],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
        ),
        BankCardWidget(
          cardNumber: '4000 1234 5678 9010',
          cardHolderName: 'G. RAYMOND',
          expiryDate: '12/20',
          cvv: '123',
          style: BankCardStyle.basic(
            textColor: Colors.white,
            cardColor: const Color(0xFF1A237E),
          ),
        ),
        BankCardWidget(
          cardNumber: '5105 1234 5678 9010',
          cardHolderName: 'MAX MUSTERMANN',
          expiryDate: '12/99',
          cvv: '456',
          style: BankCardStyle.basic(
            textColor: Colors.white,
            cardColor: _isDarkMode ? Colors.grey.shade900 : const Color(0xFF000000),
          ),
        ),
        BankCardWidget(
          cardNumber: '3782 8224 6310 005',
          cardHolderName: 'CARDHOLDER NAME',
          expiryDate: '09/26',
          cvv: '789',
          style: BankCardStyle.basic(
            textColor: Colors.white,
            cardColor: _isDarkMode ? Colors.grey.shade700 : Colors.grey.shade600,
          ),
        ),
        BankCardWidget(
          cardNumber: '4242 4242 4242 4242', // Visa example
          cardHolderName: 'VISA CARD HOLDER',
          expiryDate: '07/25',
          cvv: '123',
          style: BankCardStyle.basic(
            textColor: Colors.white,
            cardColor: Colors.blue.shade900,
          ),
        ),
        BankCardWidget(
          cardNumber: '5100 0000 0000 0000', // Mastercard example
          cardHolderName: 'MASTERCARD HOLDER',
          expiryDate: '08/26',
          cvv: '456',
          style: BankCardStyle.basic(
            textColor: Colors.white,
            cardGradient: const LinearGradient(
              colors: [Color(0xFFEB001B), Color(0xFFF79E1B)], // Mastercard colors
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        BankCardWidget(
          cardNumber: '3700 0000 0000 000', // American Express example (15 digits)
          cardHolderName: 'AMEX CARD HOLDER',
          expiryDate: '09/27',
          cvv: '789',
          style: BankCardStyle.basic(
            textColor: Colors.white,
            cardColor: Colors.green.shade800,
          ),
        ),
        BankCardWidget(
          cardNumber: '4567 8901 2345 6789', // Premium EU Banking Card
          cardHolderName: 'JOHN SMITH',
          expiryDate: '03/26',
          cvv: '987',
          style: BankCardStyle.basic(
            textColor: Colors.white,
            cardColor: Colors.indigo.shade700,
          ).copyWith(
            cardLogoAndNameBuilder: (context, cardNumber, cardHolderName) =>
                _buildCustomLogoNameExample1(context, cardNumber, cardHolderName),
          ),
        ),
        BankCardWidget(
          cardNumber: '1234 5678 9012 3456', // Business Travel Card
          cardHolderName: 'SARAH JOHNSON',
          expiryDate: '04/27',
          cvv: '654',
          style: BankCardStyle.basic(
            textColor: Colors.black,
            cardGradient: const LinearGradient(
              colors: [Colors.teal, Colors.blueGrey],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ).copyWith(
            cardLogoAndNameBuilder: (context, cardNumber, cardHolderName) =>
                _buildCustomLogoNameExample2(context, cardNumber, cardHolderName),
          ),
        ),
        BankCardWidget(
          cardNumber: '9876 5432 1098 7654', // Elite Rewards Card
          cardHolderName: 'MICHAEL BROWN',
          expiryDate: '05/28',
          cvv: '321',
          style: BankCardStyle.basic(
            textColor: Colors.white,
            cardGradient: const LinearGradient(
              colors: [Colors.teal, Colors.blueGrey],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ).copyWith(
            cardLogoAndNameBuilder: (context, cardNumber, cardHolderName) =>
                _buildCustomLogoNameExample3(context, cardNumber, cardHolderName),
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      child: Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text('Bank Card Widget Example'),
      actions: [
        IconButton(
          icon: Icon(_isDarkMode ? Icons.light_mode : Icons.dark_mode),
          onPressed: _toggleDarkMode,
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Package info card
          PackageInfoCard(isDarkMode: _isDarkMode),
          const SizedBox(height: 24),
          // Bank Card Examples Header
          _buildSectionHeader(
            'Bank Card Examples',
            Icons.credit_card,
            const Color(0xFF007BFF),
          ),
          const SizedBox(height: 20),
          // Bank Card Examples Grid
          Expanded(
            // Use Expanded to allow GridView to take available space
            child: _buildBankCardExamplesSection(),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildBankCardExamplesSection() {
    // Calculate the number of columns based on screen width
    final screenWidth = MediaQuery.of(context).size.width;
    // Define a reasonable maximum width for each grid item
    const double maxItemWidth = 420.0;
    // Calculate the number of columns, ensuring at least one
    final int crossAxisCount = (screenWidth / maxItemWidth).floor();
    final int adjustedCrossAxisCount = crossAxisCount < 1 ? 1 : crossAxisCount;

    return GridView.builder(
      // Use a key to prevent issues with hot reload when the list changes
      key: const PageStorageKey<String>('bankCardExamplesGrid'),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: adjustedCrossAxisCount,
        childAspectRatio: 1.585, // Standard credit card aspect ratio
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
      ),
      itemCount: _bankCardExamples.length,
      itemBuilder: (context, index) {
        return _bankCardExamples[index];
      },
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, Color color) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: _isDarkMode ? Colors.white : const Color(0xFF1A1A1A),
          ),
        ),
      ],
    );
  }

  void _toggleDarkMode() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  static Widget _buildCustomLogoNameExample1(BuildContext context, String cardNumber, String cardHolderName) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Deutsche Bank',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Image.network(
              'https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/Deutsche_Bank_logo_without_wordmark.svg/150px-Deutsche_Bank_logo_without_wordmark.svg.png',
              height: 48,
              color: Colors.white,
            ),
          ],
        ),
      ],
    );
  }

  static Widget _buildCustomLogoNameExample2(BuildContext context, String cardNumber, String cardHolderName) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/BNP_Paribas.svg/60px-BNP_Paribas.svg.png',
            height: 48,
          ),
          const SizedBox(height: 12.0),
          const Text(
            "Bank BNP Paribas",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  static Widget _buildCustomLogoNameExample3(BuildContext context, String cardNumber, String cardHolderName) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'BNP',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "Bank BNP Pariba",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
        const SizedBox(width: 16.0),
        Image.network(
          'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6a/BNP_Paribas.svg/60px-BNP_Paribas.svg.png',
          height: 48,
        ),
      ],
    );
  }
}
