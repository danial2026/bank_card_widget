import 'package:flutter/material.dart';

/// Comprehensive style configuration for BankCardWidget
///
/// This class provides customization options for the appearance of the bank card widget.
class BankCardStyle {
  /// Sets the background color for the card.
  final Color? cardColor;

  /// You can use a gradient for the background instead. This will override 'cardColor'.
  final Gradient? cardGradient;

  /// Controls the color of all text elements on the card.
  final Color? textColor;

  /// Sets the color of the small chip icon.
  final Color? chipColor;

  /// Determines the color of the card brand logo.
  final Color? logoColor;

  /// Provide your own widget to completely replace the default chip UI.
  final Widget? chipWidget;

  /// Want to use a custom layout for the logo and card holder name area?
  /// Provide a builder function here! It takes the context, card number, and name,
  /// and should return your custom widget. If provided, it replaces the default layout.
  final Widget Function(BuildContext context, String cardNumber, String cardHolderName)? cardLogoAndNameBuilder;

  // ==================== Typography Customization ====================

  /// Style for the main card number text.
  final TextStyle? cardNumberTextStyle;

  /// Style for the card holder's name.
  final TextStyle? cardHolderNameTextStyle;

  /// Style for the card's expiry date.
  final TextStyle? expiryDateTextStyle;

  /// Style for the smaller labels like 'Card Holder' or 'VALID THRU'.
  final TextStyle? labelTextStyle;

  /// Specify a custom font family to use for all text.
  final String? fontFamily;

  // ==================== Size & Layout Customization ====================

  /// Sets the aspect ratio of the card (width divided by height).
  final double? aspectRatio;

  /// Inner padding for the card's content.
  final EdgeInsets? padding;

  /// Spacing between the main sections (like between the number and the name/expiry).
  final double? sectionSpacing;

  /// Spacing between smaller elements within a section (like a label and its value).
  final double? elementSpacing;

  /// Sets the width of the chip icon.
  final double? chipWidth;

  /// Sets the height of the chip icon.
  final double? chipHeight;

  /// Controls the size of the card brand logo.
  final double? logoSize;

  // ==================== Shape & Border Customization ====================

  /// Sets the corner radius for the card.
  final double? cornerRadius;

  /// Defines the border style for the card.
  final BorderSide? borderSide;

  /// Adds a shadow effect to the card.
  final BoxShadow? shadow;

  // ==================== Animation & Interaction ====================

  /// How long animations should take.
  final Duration? animationDuration;

  /// The animation curve to use for transitions.
  final Curve? animationCurve;

  // ==================== Accessibility ====================

  /// Set to true to enable semantic labels for better accessibility.
  final bool enableSemanticLabels;

  /// Creates a new style configuration for the BankCardWidget.
  ///
  /// All these settings are optional. If you don't provide one, it will use a reasonable default or a value from the current theme.
  const BankCardStyle({
    // Colors!
    this.cardColor,
    this.cardGradient,
    this.textColor,
    this.chipColor,
    this.logoColor,
    this.chipWidget,
    this.cardLogoAndNameBuilder,

    // Font and Text Styles!
    this.cardNumberTextStyle,
    this.cardHolderNameTextStyle,
    this.expiryDateTextStyle,
    this.labelTextStyle,
    this.fontFamily,

    // How it looks and is laid out!
    this.aspectRatio,
    this.padding,
    this.sectionSpacing,
    this.elementSpacing,
    this.chipWidth,
    this.chipHeight,
    this.logoSize,

    // Borders and Shadows!
    this.cornerRadius,
    this.borderSide,
    this.shadow,

    // Making it move!
    this.animationDuration,
    this.animationCurve,

    // For everyone!
    this.enableSemanticLabels = true,
  });

  /// Makes a copy of this style, optionally changing some of its properties.
  BankCardStyle copyWith({
    // Colors
    Color? cardColor,
    Gradient? cardGradient,
    Color? textColor,
    Color? chipColor,
    Color? logoColor,
    Widget? chipWidget,
    Widget Function(BuildContext context, String cardNumber, String cardHolderName)? cardLogoAndNameBuilder,

    // Text Styles
    TextStyle? cardNumberTextStyle,
    TextStyle? cardHolderNameTextStyle,
    TextStyle? expiryDateTextStyle,
    TextStyle? labelTextStyle,
    String? fontFamily,

    // Size and Layout
    double? aspectRatio,
    EdgeInsets? padding,
    double? sectionSpacing,
    double? elementSpacing,
    double? chipWidth,
    double? chipHeight,
    double? logoSize,

    // Borders and Shadows
    double? cornerRadius,
    BorderSide? borderSide,
    BoxShadow? shadow,

    // Animation
    Duration? animationDuration,
    Curve? animationCurve,

    // Accessibility
    bool? enableSemanticLabels,
  }) {
    return BankCardStyle(
      // Colors
      cardColor: cardColor ?? this.cardColor,
      cardGradient: cardGradient ?? this.cardGradient,
      textColor: textColor ?? this.textColor,
      chipColor: chipColor ?? this.chipColor,
      logoColor: logoColor ?? this.logoColor,
      chipWidget: chipWidget ?? this.chipWidget,
      cardLogoAndNameBuilder: cardLogoAndNameBuilder ?? this.cardLogoAndNameBuilder,

      // Text Styles
      cardNumberTextStyle: cardNumberTextStyle ?? this.cardNumberTextStyle,
      cardHolderNameTextStyle: cardHolderNameTextStyle ?? this.cardHolderNameTextStyle,
      expiryDateTextStyle: expiryDateTextStyle ?? this.expiryDateTextStyle,
      labelTextStyle: labelTextStyle ?? this.labelTextStyle,
      fontFamily: fontFamily ?? this.fontFamily,

      // Size and Layout
      aspectRatio: aspectRatio ?? this.aspectRatio,
      padding: padding ?? this.padding,
      sectionSpacing: sectionSpacing ?? this.sectionSpacing,
      elementSpacing: elementSpacing ?? this.elementSpacing,
      chipWidth: chipWidth ?? this.chipWidth,
      chipHeight: chipHeight ?? this.chipHeight,
      logoSize: logoSize ?? this.logoSize,

      // Borders and Shadows
      cornerRadius: cornerRadius ?? this.cornerRadius,
      borderSide: borderSide ?? this.borderSide,
      shadow: shadow ?? this.shadow,

      // Animation
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,

      // Accessibility
      enableSemanticLabels: enableSemanticLabels ?? this.enableSemanticLabels,
    );
  }

  /// A basic style that's great to start with.
  static BankCardStyle basic({
    Color? cardColor,
    Gradient? cardGradient,
    Color? textColor,
    String? fontFamily,
    Widget? chipWidget,
  }) {
    return BankCardStyle(
      cardColor: cardColor,
      cardGradient: cardGradient,
      textColor: textColor,
      chipColor: Colors.amber.shade700,
      logoColor: textColor,
      chipWidget: chipWidget,
      cardNumberTextStyle: TextStyle(
        color: textColor ?? Colors.black,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        letterSpacing: 1.5,
        fontFamily: fontFamily,
      ),
      cardHolderNameTextStyle: TextStyle(
        color: textColor ?? Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: fontFamily,
      ),
      expiryDateTextStyle: TextStyle(
        color: textColor ?? Colors.black,
        fontSize: 14,
        fontWeight: FontWeight.bold,
        fontFamily: fontFamily,
      ),
      labelTextStyle: TextStyle(
        color: (textColor ?? Colors.black).withOpacity(0.7),
        fontSize: 10,
        fontFamily: fontFamily,
      ),
      fontFamily: fontFamily,
      aspectRatio: 1.585, // Standard credit card aspect ratio
      padding: const EdgeInsets.all(20.0),
      sectionSpacing: 16.0,
      elementSpacing: 4.0,
      chipWidth: 52.0,
      chipHeight: 46.0,
      logoSize: 40.0,
      cornerRadius: 15.0,
      shadow: const BoxShadow(
        color: Colors.black26,
        blurRadius: 10,
        offset: Offset(0, 5),
      ),
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeInOut,
    );
  }
}
