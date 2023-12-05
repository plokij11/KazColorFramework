import Foundation
import UIKit

/// `ColorEffects` is a utility class for applying various color effects to colors and creating gradients.
public final class ColorEffects {
    
    /// Applies a blur effect to a color.
    /// - Parameters:
    ///   - color: The input color to apply the blur effect to.
    ///   - radius: The radius of the blur effect.
    /// - Returns: The color with the applied blur effect, or the original color if the blur cannot be applied.
    public static func applyBlurEffect(toColor color: UIColor, withRadius radius: CGFloat = 10.0) -> UIColor {
        let size = CGSize(width: 100, height: 100)
        guard let image = color.toImage(size: size) else {
            return color
        }

        guard let blurredImage = image.applyBlur(radius: radius) else {
            return color
        }

        return UIColor(patternImage: blurredImage)
    }

    /// Adjusts the brightness of a color.
    /// - Parameters:
    ///   - color: The input color to adjust brightness.
    ///   - factor: The brightness adjustment factor. Must be between 0.0 and 2.0, where 1.0 represents no change.
    /// - Returns: The color with adjusted brightness. If factor is out of bounds, returns the original color.
    public static func adjustBrightness(ofColor color: UIColor, withFactor factor: CGFloat) -> UIColor {
        // Ensuring the factor is within the valid range
        guard factor >= 0.0 && factor <= 2.0 else {
            return color // Returning original color if factor is out of bounds
        }

        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        brightness = max(0.0, min(brightness * factor, 1.0))
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }

    /// Adjusts the contrast of a color.
    /// - Parameters:
    ///   - color: The input color to adjust contrast.
    ///   - factor: The contrast adjustment factor. Must be between 0.0 and 2.0, where 1.0 represents no change.
    /// - Returns: The color with adjusted contrast. If factor is out of bounds, returns the original color.
    public static func adjustContrast(ofColor color: UIColor, withFactor factor: CGFloat) -> UIColor {
        // Ensuring the factor is within the valid range
        guard factor >= 0.0 && factor <= 2.0 else {
            return color // Returning original color if factor is out of bounds
        }

        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        brightness = 0.5 + (brightness - 0.5) * factor
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }
    
    /// Adjusts the transparency (alpha) of a color.
    /// - Parameters:
    ///   - color: The input color to adjust transparency.
    ///   - alpha: The alpha value to set (0.0 to 1.0).
    /// - Returns: The color with adjusted transparency.
    public static func adjustTransparency(ofColor color: UIColor, toAlpha alpha: CGFloat) -> UIColor {
        return color.withAlphaComponent(alpha)
    }
    
    /// Creates a gradient between two colors.
    /// - Parameters:
    ///   - startColor: The starting color of the gradient.
    ///   - endColor: The ending color of the gradient.
    ///   - size: The size of the gradient (e.g., CGSize(width: 100, height: 100)).
    /// - Returns: A UIImage representing the gradient.
    public static func createGradient(from startColor: UIColor, to endColor: UIColor, withSize size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        let colors = [startColor.cgColor, endColor.cgColor] as CFArray
        let gradient = CGGradient(colorsSpace: nil, colors: colors, locations: nil)
        
        context.drawLinearGradient(gradient!, start: CGPoint.zero, end: CGPoint(x: 0, y: size.height), options: [])
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

extension UIColor {
    /// Converts a UIColor to UIImage.
    /// - Parameter size: The size of the resulting UIImage.
    /// - Returns: A UIImage representing the UIColor.
    public func toImage(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        defer { UIGraphicsEndImageContext() }
        
        let rect = CGRect(origin: .zero, size: size)
        self.setFill()
        UIRectFill(rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension UIImage {
    /// Applies a blur effect to the UIImage.
    /// - Parameter radius: The radius of the blur effect.
    /// - Returns: The UIImage with the applied blur effect.
    func applyBlur(radius: CGFloat) -> UIImage? {
        let context = CIContext(options: nil)
        guard let ciImage = CIImage(image: self) else { return nil }

        guard let filter = CIFilter(name: "CIGaussianBlur") else { return nil }
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        filter.setValue(radius, forKey: kCIInputRadiusKey)

        guard let outputImage = filter.outputImage else { return nil }
        guard let cgImage = context.createCGImage(outputImage, from: ciImage.extent) else { return nil }
        return UIImage(cgImage: cgImage)
    }
}

