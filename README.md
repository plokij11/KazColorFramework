# KazColorFramework

KazColorFramework is a powerful and flexible Swift toolkit for working with colors, allowing easy conversion between different color systems (such as RGB, HEX, HSL), blending colors, and applying various effects.

## Features

- Supports multiple color spaces: RGB, HEX, HSL, HSV, CMYK, YCbCr, XYZ, LAB.
- Functions for color blending and obtaining the average color.
- Ability to create colors based on user-defined parameters.
- Functions for applying filters and effects, such as blurring, brightness and contrast adjustment.
- Integration with CocoaPods and SwiftPackageManager for easy installation.

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

After installing the framework, you can import it and use the provided functions.

import KazColorFramework

## Examples

// Конвертація HEX у UIColor
let color = ColorConverter.HEXtoRGB(hex: "#FF5733")

// Змішування двох кольорів
let mixedColor = ColorMixer.mixColors(color1: .red, color2: .blue, ratio: 0.5)

// Застосування ефекту розмиття до кольору
let blurredColor = ColorEffects.applyBlurEffect(toColor: color, withRadius: 10.0)

## License

KazColorFramework is available under the MIT license. See the LICENSE file for more detailed information.

