import Foundation
import UIKit

/// `ColorMixer` is a utility class for mixing and manipulating UIColor objects.
public final class ColorMixer {

    /// Mixes two colors in a given ratio.
    /// - Parameters:
    ///   - color1: The first color to mix.
    ///   - color2: The second color to mix.
    ///   - ratio: The mixing ratio between the first and second color.
    ///            A value of 0.0 gives entirely the first color, 1.0 gives entirely the second color.
    ///            Values outside the range 0.0 to 1.0 are clamped within this range.
    /// - Returns: The result of mixing as a UIColor.
    public static func mixColors(color1: UIColor, color2: UIColor, ratio: CGFloat) -> UIColor {
        let clampedRatio = max(min(ratio, 1), 0) // Ensuring the ratio is within the range 0.0 to 1.0
        let inverseRatio = 1 - clampedRatio

        var r1: CGFloat = 0, g1: CGFloat = 0, b1: CGFloat = 0, a1: CGFloat = 0
        var r2: CGFloat = 0, g2: CGFloat = 0, b2: CGFloat = 0, a2: CGFloat = 0

        color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1)
        color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2)

        let r = r1 * inverseRatio + r2 * clampedRatio
        let g = g1 * inverseRatio + g2 * clampedRatio
        let b = b1 * inverseRatio + b2 * clampedRatio
        let a = a1 * inverseRatio + a2 * clampedRatio

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }

    /// Gets the average color from a list of colors.
    /// - Parameter colors: An array of UIColor objects to mix.
    /// - Returns: The average color as a UIColor.
    public static func averageColor(colors: [UIColor]) -> UIColor {
        var sumRed: CGFloat = 0
        var sumGreen: CGFloat = 0
        var sumBlue: CGFloat = 0
        var sumAlpha: CGFloat = 0

        for color in colors {
            var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
            color.getRed(&r, green: &g, blue: &b, alpha: &a)

            sumRed += r
            sumGreen += g
            sumBlue += b
            sumAlpha += a
        }

        let count = CGFloat(colors.count)
        return UIColor(red: sumRed / count, green: sumGreen / count, blue: sumBlue / count, alpha: sumAlpha / count)
    }
    
    /// Mixes an arbitrary number of colors by calculating the average color.
    /// - Parameter colors: An array of colors to mix.
    /// - Returns: The result of mixing as a UIColor. Returns clear color if the array is empty.
    ///   If the array is empty, a clear color is returned as there are no colors to mix.
    public static func mixMultipleColors(colors: [UIColor]) -> UIColor {
        guard !colors.isEmpty else {
            // If no colors provided, return a clear color
            return UIColor.clear
        }

        var sumRed: CGFloat = 0
        var sumGreen: CGFloat = 0
        var sumBlue: CGFloat = 0
        var sumAlpha: CGFloat = 0

        for color in colors {
            var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
            color.getRed(&r, green: &g, blue: &b, alpha: &a)

            sumRed += r
            sumGreen += g
            sumBlue += b
            sumAlpha += a
        }

        let count = CGFloat(colors.count)
        return UIColor(red: sumRed / count, green: sumGreen / count, blue: sumBlue / count, alpha: sumAlpha / count)
    }
}

