import 'package:flutter/material.dart';
import 'models/bank_card_style.dart'; // Provides styling options for the bank card widget.

/// A widget that beautifully displays bank card information.
class BankCardWidget extends StatefulWidget {
  /// The primary account number of the bank card.
  final String cardNumber;

  /// The name of the person the card is issued to.
  final String cardHolderName;

  /// The date the card is valid until (format: MM/YY).
  final String expiryDate;

  /// The card verification value (CVV) for security.
  final String cvv;

  /// Customize the look and feel of the card using BankCardStyle.
  final BankCardStyle? style;

  const BankCardWidget({
    super.key,
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    required this.cvv,
    this.style,
  });

  @override
  State<BankCardWidget> createState() => _BankCardWidgetState();
}

class _BankCardWidgetState extends State<BankCardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use provided style or a basic default
    final style = widget.style ?? BankCardStyle.basic();
    final screenWidth = MediaQuery.of(context).size.width;
    // Minimum width needed to display the card comfortably.
    const double minSupportedWidth = 405.0;

    if (screenWidth < minSupportedWidth) {
      // Show a message if the screen is too narrow.
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.warning_amber, color: Colors.red, size: 40),
            SizedBox(height: 10),
            Text(
              'This screen size isn\'t ideal for displaying the bank card.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.redAccent,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    } else {
      // Build the actual bank card layout.
      // Standard credit card dimensions are roughly 85.6mm x 53.98mm.
      // We use an aspect ratio for correct proportions and a max width to keep it from getting too big.
      const double maxCardWidth = 420.0; // Maximum width for the card.
      final double maxCardHeight = maxCardWidth / (style.aspectRatio ?? 1.585); // Calculate height based on aspect ratio.

      // Determine text and logo colors, falling back to sensible defaults if not specified.
      final Color cardTextColor = style.textColor ?? Colors.white;
      final Color cardLogoColor = style.logoColor ?? cardTextColor;

      return Center(
        // Center the card horizontally.
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: maxCardWidth,
            maxHeight: maxCardHeight,
          ),
          child: AspectRatio(
            aspectRatio: style.aspectRatio ?? 1.585, // Maintain the correct card shape.
            child: Container(
              decoration: BoxDecoration(
                color: style.cardColor, // Apply background color
                gradient: style.cardGradient, // Apply gradient background (overrides color if present)
                borderRadius: BorderRadius.circular(style.cornerRadius ?? 15.0), // Rounded corners.
                boxShadow: style.shadow != null // Add shadow if defined.
                    ? [style.shadow!]
                    : const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 5),
                        ),
                      ],
              ),
              child: Padding(
                padding: style.padding ?? const EdgeInsets.all(20.0), // Apply inner padding.
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Top row: Chip, Contactless Icon, and Card Type Logo (or custom builder output).
                    (style.cardLogoAndNameBuilder != null) // Check if a custom builder is provided.
                        ? style.cardLogoAndNameBuilder!(context, widget.cardNumber, widget.cardHolderName)
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Display contactless icon and card type logo using the default logic.
                              Row(
                                children: [
                                  // Contactless Icon (a simple placeholder icon).
                                  Icon(Icons.wifi, size: style.logoSize ?? 30, color: cardLogoColor),
                                  SizedBox(width: (style.elementSpacing ?? 4.0) * 2), // Spacing
                                  // Card Type Logo (determined by card number prefix).
                                  _buildCardLogo(style.logoSize ?? 40.0, cardLogoColor),
                                ],
                              ),
                            ],
                          ),
                    SizedBox(height: style.sectionSpacing ?? 16.0), // Spacing between top and middle sections.
                    // Middle row: Chip and Card Number.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center, // Vertically align items in this row.
                      children: [
                        // Display the chip widget (custom or default).
                        if (style.chipWidget != null) // Use custom chip if provided.
                          style.chipWidget!
                        else // Otherwise, draw the default chip.
                          CustomPaint(
                            size: Size(style.chipWidth ?? 52, style.chipHeight ?? 46), // Set the size of the custom paint area.
                            painter: ChipPainter(
                              chipColor: style.chipColor ?? Colors.amber.shade700, // Chip background color.
                              lineColor: Color.lerp(
                                    style.chipColor ?? Colors.amber.shade700,
                                    Colors.black,
                                    0.2,
                                  ) ??
                                  Colors.amber.shade900, // Color for chip lines.
                            ),
                          ),
                        SizedBox(width: style.sectionSpacing ?? 16.0), // Spacing between chip and card number.
                        // Display the card number.
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Display the first four digits above the main number.
                              Text(
                                widget.cardNumber.substring(0, 4), // Get the first four digits.
                                style: style.cardNumberTextStyle?.copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      letterSpacing: 1.0,
                                    ) ??
                                    TextStyle(
                                      color: cardTextColor,
                                      fontSize: 12,
                                    ),
                              ),
                              SizedBox(height: (style.elementSpacing ?? 4.0) / 2), // Small spacing.
                              // Display the full card number, formatted.
                              Text(
                                widget.cardNumber
                                    .replaceAllMapped(RegExp(r'(.{4})'), (match) => '${match.group(0)} ') // Add spaces every 4 digits.
                                    .trim(), // Remove trailing space.
                                style: style.cardNumberTextStyle ?? // Use custom style or a default.
                                    TextStyle(
                                      color: cardTextColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 2.0,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: style.sectionSpacing ?? 16.0), // Spacing between middle and bottom sections.
                    // Bottom row: Card Holder Name and Expiry Date (or part of custom builder).
                    // Note: If a custom builder was used in the top row, this row might not be needed,
                    // depending on how the custom builder handles the layout.
                    // The condition to use the custom builder is in the top-level Column's children list.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Display the card holder name.
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Card Holder',
                              style: style.labelTextStyle ?? // Use custom style or a default.
                                  TextStyle(
                                    color: cardTextColor.withOpacity(0.7), // Slightly transparent label.
                                    fontSize: 10,
                                  ),
                            ),
                            SizedBox(height: style.elementSpacing ?? 4.0), // Spacing.
                            Text(
                              widget.cardHolderName,
                              style: style.cardHolderNameTextStyle ?? // Use custom style or a default.
                                  TextStyle(
                                    color: cardTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        // Display the expiry date.
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'VALID THRU',
                              style: style.labelTextStyle ?? // Use custom style or a default.
                                  TextStyle(
                                    color: cardTextColor.withOpacity(0.7), // Slightly transparent label.
                                    fontSize: 8,
                                  ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: style.elementSpacing ?? 4.0), // Spacing.
                            Text(
                              widget.expiryDate,
                              style: style.expiryDateTextStyle ?? // Use custom style or a default.
                                  TextStyle(
                                    color: cardTextColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  // Helper function to display a placeholder logo based on the card number prefix.
  // This is used when no custom cardLogoAndNameBuilder is provided.
  Widget _buildCardLogo(double size, Color color) {
    String logoText = '';
    Widget logoWidget = SizedBox.shrink(); // Start with an empty box.

    // Determine the card type based on the first digit(s).
    if (widget.cardNumber.startsWith('4')) {
      logoText = 'VISA';
      logoWidget = Text(
        logoText,
        style: TextStyle(
          color: color,
          fontSize: size * 0.8,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      );
    } else if (widget.cardNumber.startsWith('5')) {
      logoText = 'MASTERCARD';
      logoWidget = Text(
        logoText,
        style: TextStyle(
          color: color,
          fontSize: size * 0.8,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      );
    } else if (widget.cardNumber.startsWith('34') || widget.cardNumber.startsWith('37')) {
      logoText = 'AMEX';
      logoWidget = Text(
        logoText,
        style: TextStyle(
          color: color,
          fontSize: size * 0.8,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      );
    } else if (widget.cardNumber.startsWith('6')) {
      logoText = 'DISCOVER';
      logoWidget = Text(
        logoText,
        style: TextStyle(
          color: color,
          fontSize: size * 0.8,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      );
    } else if (widget.cardNumber.startsWith('35')) {
      logoText = 'JCB';
      logoWidget = Text(
        logoText,
        style: TextStyle(
          color: color,
          fontSize: size * 0.8,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      );
    }

    return logoWidget; // Return the created logo widget.
  }
}

// CustomPainter to draw the visual representation of a bank card chip.
class ChipPainter extends CustomPainter {
  final Color chipColor; // The background color of the chip.
  final Color lineColor; // The color for the lines and outlines on the chip.

  ChipPainter({required this.chipColor, required this.lineColor});

  @override
  void paint(Canvas canvas, Size size) {
    // Paint for filling the chip shape.
    final paint = Paint()
      ..color = chipColor
      ..style = PaintingStyle.fill;

    // Paint for drawing lines and outlines.
    final linePaint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = size.width * 0.02; // Adjust stroke width based on chip size.

    // --- Drawing the main chip shape --- (A standard contact plate shape, centered within its bounds).
    final double radius = size.width * 0.08; // Corner radius for the chip shape.
    final double shapeHeight = size.height * 0.7; // The height of the main shape relative to the total size.
    final double verticalOffset = (size.height - shapeHeight) / 2; // Calculate the vertical offset to center the shape.
    final double sideIndentation = size.width * 0.1; // Indentation from the sides.

    final path = Path()
      ..moveTo(sideIndentation + radius, verticalOffset)
      ..lineTo(size.width - sideIndentation - radius, verticalOffset)
      ..arcToPoint(Offset(size.width - sideIndentation, verticalOffset + radius), radius: Radius.circular(radius), clockwise: true)
      ..lineTo(size.width - sideIndentation, verticalOffset + shapeHeight - radius)
      ..arcToPoint(Offset(size.width - sideIndentation - radius, verticalOffset + shapeHeight),
          radius: Radius.circular(radius), clockwise: true)
      ..lineTo(sideIndentation + radius, verticalOffset + shapeHeight)
      ..arcToPoint(Offset(sideIndentation, verticalOffset + shapeHeight - radius), radius: Radius.circular(radius), clockwise: true)
      ..lineTo(sideIndentation, verticalOffset + radius)
      ..arcToPoint(Offset(sideIndentation + radius, verticalOffset), radius: Radius.circular(radius), clockwise: true);

    canvas.drawPath(path, paint); // Fill the main chip shape.
    canvas.drawPath(path, linePaint); // Draw the outline of the main shape.

    // --- Drawing internal contact lines --- (A simplified representation of the electrical contacts, centered).

    // Horizontal contact segments.
    final double hLineY1 = size.height * 0.35; // Vertical position for the first set of horizontal lines.
    final double hLineY2 = size.height * 0.65; // Vertical position for the second set of horizontal lines.
    final double hLineLength = size.width * 0.15; // Length of each horizontal segment.
    final double hLineStartX1 = size.width * 0.2; // Starting X for the left horizontal segments.
    final double hLineStartX2 = size.width * 0.65; // Starting X for the right horizontal segments.

    canvas.drawLine(Offset(hLineStartX1, hLineY1), Offset(hLineStartX1 + hLineLength, hLineY1), linePaint);
    canvas.drawLine(Offset(hLineStartX2, hLineY1), Offset(hLineStartX2 + hLineLength, hLineY1), linePaint);

    canvas.drawLine(Offset(hLineStartX1, hLineY2), Offset(hLineStartX1 + hLineLength, hLineY2), linePaint);
    canvas.drawLine(Offset(hLineStartX2, hLineY2), Offset(hLineStartX2 + hLineLength, hLineY2), linePaint);

    // Vertical contact segments.
    final double vLineX1 = size.width * 0.35; // Horizontal position for the first set of vertical lines.
    final double vLineX2 = size.width * 0.65; // Horizontal position for the second set of vertical lines.
    final double vLineLength = size.height * 0.15; // Length of each vertical segment.
    final double vLineStartY1 = size.height * 0.2; // Starting Y for the top vertical segments.
    final double vLineStartY2 = size.height * 0.65; // Starting Y for the bottom vertical segments.

    canvas.drawLine(Offset(vLineX1, vLineStartY1), Offset(vLineX1, vLineStartY1 + vLineLength), linePaint);
    canvas.drawLine(Offset(vLineX1, vLineStartY2), Offset(vLineX1, vLineStartY2 + vLineLength), linePaint);

    canvas.drawLine(Offset(vLineX2, vLineStartY1), Offset(vLineX2, vLineStartY1 + vLineLength), linePaint);
    canvas.drawLine(Offset(vLineX2, vLineStartY2), Offset(vLineX2, vLineStartY2 + vLineLength), linePaint);

    // Central square contact (a simplified representation, centered).
    final double centralSquareSize = size.width * 0.2; // Size of the central square.
    final double centralSquareX = (size.width - centralSquareSize) / 2; // X coordinate to center the square.
    final double centralSquareY = (size.height - centralSquareSize) / 2; // Y coordinate to center the square.
    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromLTWH(centralSquareX, centralSquareY, centralSquareSize, centralSquareSize), Radius.circular(centralSquareSize * 0.1)),
        linePaint); // Draw the outline of the central square.

    // Note: Achieving an exact replica of a specific chip design programmatically
    // would require precise measurements or vector data of the chip geometry.
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // Only repaint the chip if its color or line color changes.
    return oldDelegate is ChipPainter && (oldDelegate.chipColor != chipColor || oldDelegate.lineColor != lineColor);
  }
}
