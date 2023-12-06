# KazColorFramework

KazColorFramework is a comprehensive framework for color manipulation and conversion in iOS development. This framework provides a wide range of functionalities to work with colors, including conversion between different color formats (like RGB, HEX, HSL), color blending operations, and the creation of custom colors based on user-specified parameters. Additionally, it offers various color filters and effects, enhancing the visual aspects of iOS applications.

## Features

- Supports multiple color spaces: RGB, HEX, HSL, HSV, CMYK, YCbCr, XYZ, LAB.
- Functions for color blending and obtaining the average color.
- Ability to create colors based on user-defined parameters.
- Functions for applying filters and effects, such as blurring, brightness and contrast adjustment.
- Integration with CocoaPods and SwiftPackageManager for easy installation.

## Topics

### Color Conversion

- RGBtoHEX: Convert RGB color values to HEX color strings.
- HEXtoRGB: Convert HEX color strings to UIColor objects.
- RGBtoHSL: Convert RGB color values to HSL values.
- HSLtoRGB: Convert HSL values to RGB color values.
- HSVtoRGB: Convert HSV values to RGB color values.
- RGBtoHSV: Convert RGB color values to HSV values.
- CMYKtoRGB: Convert CMYK values to RGB color values.
- RGBtoCMYK: Convert RGB color values to CMYK values.
- YCbCrtoRGB: Convert YCbCr values to RGB color values.
- RGBtoYCbCr: Convert RGB color values to YCbCr values.
- XYZtoRGB: Convert XYZ values to RGB color values in the sRGB color space with D65 illuminant.
- RGBtoXYZ: Convert RGB color values to XYZ values based on sRGB color space and D65 illuminant.
- LABtoRGB: Convert LAB color values to RGB color values.
- RGBtoLAB: Convert RGB color values to LAB values.
- LABtoXYZ: Convert LAB color values to XYZ values using the D65 illuminant and the CIE 1931 2° standard observer.
- XYZtoLAB: Convert XYZ values to LAB color values using the D65 illuminant and the CIE 1931 2° standard observer.

### Color Mixing and Creation

- mixColors: Mix two UIColor objects in a given ratio.
- averageColor: Compute the average color from a list of UIColor objects.
- mixMultipleColors: Mix multiple UIColor objects to calculate the average color.
- createColor: Create custom colors using hue, saturation, and brightness values or based on color names.
- complementaryColor: Get the complementary color for a given UIColor object.

### Color Effects and Filters

- applyBlurEffect: Apply a blur effect to a UIColor object.
- adjustBrightness: Adjust the brightness of a UIColor object.
- adjustContrast: Adjust the contrast of a UIColor object.
- adjustTransparency: Adjust the transparency (alpha value) of a UIColor object.
- createGradient: Create a gradient image from two UIColor objects.

### Saving and Loading Color Settings

- saveColorSettings: Save color settings to a file.
- loadColorSettings: Load color settings from a file.

### Utilities

- Extensions for UIColor and UIImage to support conversion and effect application functions.

## Requirements

- iOS 13.0+
- Xcode 15.0+
- Swift 5.0+

## Installation

### CocoaPods

To integrate KazColorFramework into your Xcode project using CocoaPods, add the following line to your `Podfile`:
pod 'KazColorFramework'

### SwiftPacketManager

To integrate KazColorFramework into your Xcode project using SwiftPackageManager, go to your project's Package Dependencies, click '+' and find the KazColorFramework framework using this link:
"https://github.com/plokij11/KazColorFramework"

## Usage

To use KazColorFramework in your project, import the framework and access its functionalities directly through the static methods provided. Ensure to handle any errors or exceptions as per your project's requirements.

import KazColorFramework

## Examples

// Конвертація HEX у UIColor
let color = ColorConverter.HEXtoRGB(hex: "#FF5733")

// Змішування двох кольорів
let mixedColor = ColorMixer.mixColors(color1: .red, color2: .blue, ratio: 0.5)

// Застосування ефекту розмиття до кольору
let blurredColor = ColorEffects.applyBlurEffect(toColor: color, withRadius: 10.0)

## Note

KazColorFramework is designed to enhance color manipulation in iOS app development. It provides an easy-to-use interface for developers to work with colors, making the process of color conversion, creation, and effect application more efficient and streamlined.

## License

KazColorFramework is available under the MIT license. See the LICENSE file for more detailed information.

