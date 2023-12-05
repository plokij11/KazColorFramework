import Foundation
import UIKit

/// `ColorConverter` is a utility class providing a collection of static methods to convert between different color representations.
/// It supports conversions between RGB, HEX, HSL, HSV, CMYK, YCbCr, and XYZ color spaces.
public final class ColorConverter {
    
    /// Converts RGB color values to a HEX color string.
    /// - Parameters:
    ///   - red: Red component of the color, in the range 0 to 1.
    ///   - green: Green component of the color, in the range 0 to 1.
    ///   - blue: Blue component of the color, in the range 0 to 1.
    /// - Returns: A HEX color string representation of the input RGB color.
    public static func RGBtoHEX(red: CGFloat, green: CGFloat, blue: CGFloat) -> String {
        return String(format: "#%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255))
    }
    
    /// Converts a HEX color string to a UIColor object.
    /// - Parameter hex: A HEX color string.
    /// - Returns: A UIColor object corresponding to the input HEX color string. If the input string is not in a valid HEX format, returns a default gray color.
    public static func HEXtoRGB(hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            // Return a default color if HEX string is invalid
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    /// Converts RGB color values to HSL color values.
    /// - Parameters:
    ///   - red: Red component of the color, in the range 0 to 1.
    ///   - green: Green component of the color, in the range 0 to 1.
    ///   - blue: Blue component of the color, in the range 0 to 1.
    /// - Returns: A tuple containing the HSL representation (hue, saturation, lightness) of the color.
    public static func RGBtoHSL(red: CGFloat, green: CGFloat, blue: CGFloat) -> (hue: CGFloat, saturation: CGFloat, lightness: CGFloat) {
        let minVal = min(red, green, blue)
        let maxVal = max(red, green, blue)
        let delta = maxVal - minVal

        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        let lightness: CGFloat = (maxVal + minVal) / 2

        if delta != 0 {
            saturation = lightness < 0.5 ? delta / (maxVal + minVal) : delta / (2 - maxVal - minVal)

            if maxVal == red {
                hue = (green - blue) / delta + (green < blue ? 6 : 0)
            } else if maxVal == green {
                hue = (blue - red) / delta + 2
            } else {
                hue = (red - green) / delta + 4
            }

            hue /= 6
        }

        return (hue, saturation, lightness)
    }
    
    /// Converts HSL (Hue, Saturation, Lightness) color values to RGB (Red, Green, Blue).
    /// - Parameters:
    ///   - hue: The hue component of the color, in the range 0 to 1.
    ///   - saturation: The saturation component of the color, in the range 0 to 1.
    ///   - lightness: The lightness component of the color, in the range 0 to 1.
    /// - Returns: A tuple containing the RGB representation (red, green, blue) of the color.
    public static func HSLtoRGB(hue: CGFloat, saturation: CGFloat, lightness: CGFloat) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        let c = (1.0 - abs(2.0 * lightness - 1.0)) * saturation
        let x = c * (1.0 - abs((hue * 6.0).truncatingRemainder(dividingBy: 2.0) - 1.0))
        let m = lightness - 0.5 * c
        let (r, g, b): (CGFloat, CGFloat, CGFloat)

        switch hue {
        case let h where h < 1.0 / 6.0:
            (r, g, b) = (c, x, 0)
        case let h where h < 2.0 / 6.0:
            (r, g, b) = (x, c, 0)
        case let h where h < 3.0 / 6.0:
            (r, g, b) = (0, c, x)
        case let h where h < 4.0 / 6.0:
            (r, g, b) = (0, x, c)
        case let h where h < 5.0 / 6.0:
            (r, g, b) = (x, 0, c)
        default:
            (r, g, b) = (c, 0, x)
        }

        return (r + m, g + m, b + m)
    }
    
    /// Converts HSV (Hue, Saturation, Value) color values to RGB (Red, Green, Blue).
    /// - Parameters:
    ///   - hue: The hue component of the color, in the range 0 to 1.
    ///   - saturation: The saturation component of the color, in the range 0 to 1.
    ///   - value: The value component of the color, in the range 0 to 1.
    /// - Returns: A tuple containing the RGB representation (red, green, blue) of the color.
    public static func HSVtoRGB(hue: CGFloat, saturation: CGFloat, value: CGFloat) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        let c = value * saturation
        let x = c * (1 - abs((hue * 6).truncatingRemainder(dividingBy: 2) - 1))
        let m = value - c
        let (r, g, b): (CGFloat, CGFloat, CGFloat)

        switch hue {
        case let h where h < 1.0 / 6.0:
            (r, g, b) = (c, x, 0)
        case let h where h < 2.0 / 6.0:
            (r, g, b) = (x, c, 0)
        case let h where h < 3.0 / 6.0:
            (r, g, b) = (0, c, x)
        case let h where h < 4.0 / 6.0:
            (r, g, b) = (0, x, c)
        case let h where h < 5.0 / 6.0:
            (r, g, b) = (x, 0, c)
        case let h where h < 6.0 / 6.0:
            (r, g, b) = (c, 0, x)
        default:
            (r, g, b) = (0, 0, 0)
        }

        return (r + m, g + m, b + m)
    }
    
    /// Converts RGB (Red, Green, Blue) color values to HSV (Hue, Saturation, Value).
    /// - Parameters:
    ///   - red: The red component of the color, in the range 0 to 1.
    ///   - green: The green component of the color, in the range 0 to 1.
    ///   - blue: The blue component of the color, in the range 0 to 1.
    /// - Returns: A tuple containing the HSV representation (hue, saturation, value) of the color.
    public static func RGBtoHSV(red: CGFloat, green: CGFloat, blue: CGFloat) -> (hue: CGFloat, saturation: CGFloat, value: CGFloat) {
        let minVal = min(red, green, blue)
        let maxVal = max(red, green, blue)
        let delta = maxVal - minVal

        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        let value: CGFloat = maxVal

        if maxVal != 0 {
            saturation = delta / maxVal

            if red == maxVal {
                hue = (green - blue) / delta
            } else if green == maxVal {
                hue = 2 + (blue - red) / delta
            } else {
                hue = 4 + (red - green) / delta
            }

            hue *= 60
            if hue < 0 {
                hue += 360
            }
        }

        return (hue / 360, saturation, value)
    }
    
    /// Converts CMYK (Cyan, Magenta, Yellow, Key/Black) color values to RGB (Red, Green, Blue).
    /// - Parameters:
    ///   - cyan: The cyan component of the color, in the range 0 to 1.
    ///   - magenta: The magenta component of the color, in the range 0 to 1.
    ///   - yellow: The yellow component of the color, in the range 0 to 1.
    ///   - key: The key (black) component of the color, in the range 0 to 1.
    /// - Returns: A tuple containing the RGB representation (red, green, blue) of the color.
    public static func CMYKtoRGB(cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, key: CGFloat) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        let r = (1 - cyan) * (1 - key)
        let g = (1 - magenta) * (1 - key)
        let b = (1 - yellow) * (1 - key)

        return (r, g, b)
    }
    
    /// Converts RGB (Red, Green, Blue) color values to CMYK (Cyan, Magenta, Yellow, Key/Black).
    /// - Parameters:
    ///   - red: The red component of the color, in the range 0 to 1.
    ///   - green: The green component of the color, in the range 0 to 1.
    ///   - blue: The blue component of the color, in the range 0 to 1.
    /// - Returns: A tuple containing the CMYK representation (cyan, magenta, yellow, key) of the color.
    public static func RGBtoCMYK(red: CGFloat, green: CGFloat, blue: CGFloat) -> (cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, key: CGFloat) {
        let c = 1 - red
        let m = 1 - green
        let y = 1 - blue
        let k = min(c, m, y)

        let cyan = (c - k) / (1 - k)
        let magenta = (m - k) / (1 - k)
        let yellow = (y - k) / (1 - k)

        return (cyan, magenta, yellow, k)
    }
    
    /// Converts YCbCr color values to RGB (Red, Green, Blue).
    /// - Parameters:
    ///   - y: The luma component (Y) of the color.
    ///   - cb: The blue-difference chroma component (Cb) of the color.
    ///   - cr: The red-difference chroma component (Cr) of the color.
    /// - Returns: A tuple containing the RGB representation (red, green, blue) of the color.
    public static func YCbCrtoRGB(y: CGFloat, cb: CGFloat, cr: CGFloat) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        let r = y + 1.402 * (cr - 128)
        let g = y - 0.344136 * (cb - 128) - 0.714136 * (cr - 128)
        let b = y + 1.772 * (cb - 128)

        return (max(min(r, 255), 0), max(min(g, 255), 0), max(min(b, 255), 0))
    }
    
    /// Converts RGB (Red, Green, Blue) color values to YCbCr.
    /// - Parameters:
    ///   - red: The red component of the color, in the range 0 to 1.
    ///   - green: The green component of the color, in the range 0 to 1.
    ///   - blue: The blue component of the color, in the range 0 to 1.
    /// - Returns: A tuple containing the YCbCr representation (Y, Cb, Cr) of the color.
    public static func RGBtoYCbCr(red: CGFloat, green: CGFloat, blue: CGFloat) -> (y: CGFloat, cb: CGFloat, cr: CGFloat) {
        let y = 0.299 * red + 0.587 * green + 0.114 * blue
        let cb = 128 - 0.168736 * red - 0.331264 * green + 0.5 * blue
        let cr = 128 + 0.5 * red - 0.418688 * green - 0.081312 * blue

        return (y, cb, cr)
    }
    
    /// Converts XYZ color values to RGB (Red, Green, Blue).
    /// This conversion assumes an sRGB color space and D65 illuminant.
    /// - Parameters:
    ///   - x: The X component in the XYZ color space.
    ///   - y: The Y component in the XYZ color space (luminance).
    ///   - z: The Z component in the XYZ color space.
    /// - Returns: A tuple containing the RGB representation (red, green, blue) of the color.
    public static func XYZtoRGB(x: CGFloat, y: CGFloat, z: CGFloat) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var r = x * 3.2406 + y * -1.5372 + z * -0.4986
        var g = x * -0.9689 + y * 1.8758 + z * 0.0415
        var b = x * 0.0557 + y * -0.2040 + z * 1.0570

        r = r > 0.0031308 ? 1.055 * pow(r, 1.0 / 2.4) - 0.055 : 12.92 * r
        g = g > 0.0031308 ? 1.055 * pow(g, 1.0 / 2.4) - 0.055 : 12.92 * g
        b = b > 0.0031308 ? 1.055 * pow(b, 1.0 / 2.4) - 0.055 : 12.92 * b

        return (max(min(r, 1), 0), max(min(g, 1), 0), max(min(b, 1), 0))
    }

    /// Converts RGB (Red, Green, Blue) color values to XYZ.
    /// This conversion is based on the sRGB color space and D65 illuminant.
    /// It's used to transform color values from a typical camera RGB color space to a linear XYZ color space.
    /// - Parameters:
    ///   - red: The red component of the color, in the range 0 to 1.
    ///   - green: The green component of the color, in the range 0 to 1.
    ///   - blue: The blue component of the color, in the range 0 to 1.
    /// - Returns: A tuple containing the XYZ representation (X, Y, Z) of the color.
    public static func RGBtoXYZ(red: CGFloat, green: CGFloat, blue: CGFloat) -> (x: CGFloat, y: CGFloat, z: CGFloat) {
        let r = red > 0.04045 ? pow((red + 0.055) / 1.055, 2.4) : red / 12.92
        let g = green > 0.04045 ? pow((green + 0.055) / 1.055, 2.4) : green / 12.92
        let b = blue > 0.04045 ? pow((blue + 0.055) / 1.055, 2.4) : blue / 12.92

        let x = r * 0.4124 + g * 0.3576 + b * 0.1805
        let y = r * 0.2126 + g * 0.7152 + b * 0.0722
        let z = r * 0.0193 + g * 0.1192 + b * 0.9505

        return (x, y, z)
    }
    
    /// Converts LAB color values to RGB (Red, Green, Blue).
    /// - Parameters:
    ///   - l: The lightness component (L*) of the color.
    ///   - a: The a* component (green-red axis) of the color.
    ///   - b: The b* component (blue-yellow axis) of the color.
    /// - Returns: A tuple containing the RGB representation (red, green, blue) of the color.
    public static func LABtoRGB(l: CGFloat, a: CGFloat, b: CGFloat) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
        let xyz = LABtoXYZ(l: l, a: a, b: b)

        return XYZtoRGB(x: xyz.x, y: xyz.y, z: xyz.z)
    }
    
    /// Converts RGB (Red, Green, Blue) color values to LAB.
    /// - Parameters:
    ///   - red: The red component of the color, in the range 0 to 1.
    ///   - green: The green component of the color, in the range 0 to 1.
    ///   - blue: The blue component of the color, in the range 0 to 1.
    /// - Returns: A tuple containing the LAB representation (L*, a*, b*) of the color.
    public static func RGBtoLAB(red: CGFloat, green: CGFloat, blue: CGFloat) -> (l: CGFloat, a: CGFloat, b: CGFloat) {
        let xyz = RGBtoXYZ(red: red, green: green, blue: blue)
        
        return XYZtoLAB(x: xyz.x, y: xyz.y, z: xyz.z)
    }
    
    /// Converts LAB (Luminance, a*, b*) color values to XYZ.
    /// This conversion uses the D65 illuminant and the CIE 1931 2° standard observer.
    /// - Parameters:
    ///   - l: The lightness component L* of the color.
    ///   - a: The a* component, representing the position between magenta and green.
    ///   - b: The b* component, representing the position between yellow and blue.
    /// - Returns: A tuple containing the XYZ representation (X, Y, Z) of the color.
    public static func LABtoXYZ(l: CGFloat, a: CGFloat, b: CGFloat) -> (x: CGFloat, y: CGFloat, z: CGFloat) {
        let fy = (l + 16) / 116
        let fx = a / 500 + fy
        let fz = fy - b / 200

        let xr = fx > 0.206897 ? pow(fx, 3) : (fx - 16.0 / 116.0) / 7.787
        let yr = l > 7.999625 ? pow((l + 16.0) / 116.0, 3) : l / 903.3
        let zr = fz > 0.206897 ? pow(fz, 3) : (fz - 16.0 / 116.0) / 7.787

        let xRef = 95.047
        let yRef = 100.0
        let zRef = 108.883

        let x = xr * xRef
        let y = yr * yRef
        let z = zr * zRef

        return (x, y, z)
    }
    
    /// Converts XYZ color values to LAB (Luminance, a*, b*).
    /// This conversion uses the D65 illuminant and the CIE 1931 2° standard observer.
    /// - Parameters:
    ///   - x: The X component in the XYZ color space.
    ///   - y: The Y component in the XYZ color space (luminance).
    ///   - z: The Z component in the XYZ color space.
    /// - Returns: A tuple containing the LAB representation (L*, a*, b*) of the color.
    public static func XYZtoLAB(x: CGFloat, y: CGFloat, z: CGFloat) -> (l: CGFloat, a: CGFloat, b: CGFloat) {
        let xRef = 95.047
        let yRef = 100.0
        let zRef = 108.883

        let xr = x / xRef
        let yr = y / yRef
        let zr = z / zRef

        let fx = xr > 0.008856 ? pow(xr, 1.0 / 3.0) : (7.787 * xr) + (16.0 / 116.0)
        let fy = yr > 0.008856 ? pow(yr, 1.0 / 3.0) : (7.787 * yr) + (16.0 / 116.0)
        let fz = zr > 0.008856 ? pow(zr, 1.0 / 3.0) : (7.787 * zr) + (16.0 / 116.0)

        let l = (116 * fy) - 16
        let a = 500 * (fx - fy)
        let b = 200 * (fy - fz)

        return (l, a, b)
    }

}

