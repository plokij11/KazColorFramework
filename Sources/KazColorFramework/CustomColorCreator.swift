import Foundation
import UIKit

/// `CustomColorCreator` is a utility class for creating custom UIColor objects.
public final class CustomColorCreator {
    
    /// Creates a color based on the specified hue, saturation, and brightness.
    /// - Parameters:
    ///   - hue: The hue of the color (ranging from 0.0 to 1.0).
    ///   - saturation: The saturation of the color (ranging from 0.0 to 1.0).
    ///   - brightness: The brightness of the color (ranging from 0.0 to 1.0).
    /// - Returns: The created color based on the provided parameters.
    public static func createColor(hue: CGFloat, saturation: CGFloat, brightness: CGFloat) -> UIColor {
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
    
    /// Creates a color based on the color name.
    /// - Parameter name: The name of the color (e.g., "red," "green," "blue," etc.).
    /// - Returns: The created color based on the name or black color if the name is invalid.
    public static func createColor(fromName name: String) -> UIColor {
        switch name.lowercased() {
        case "red":
            return UIColor.red
        case "green":
            return UIColor.green
        case "blue":
            return UIColor.blue
        case "yellow":
            return UIColor.yellow
        case "purple":
            return UIColor.purple
        case "orange":
            return UIColor.orange
        case "brown":
            return UIColor.brown
        case "gray":
            return UIColor.gray
        default:
            return UIColor.black
        }
    }
    
    /// Creates a color based on an HTML/CSS color code.
    /// - Parameter htmlColorCode: The HTML/CSS color code (e.g., "#FF5733").
    /// - Returns: The created color based on the HTML/CSS color code or nil if the code is invalid.
    public static func createColor(fromHTMLCode htmlColorCode: String) -> UIColor? {
        var formattedCode = htmlColorCode.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if formattedCode.hasPrefix("#") {
            formattedCode = String(formattedCode.dropFirst())
        }
        
        guard formattedCode.count == 6 else { return nil }

        let scanner = Scanner(string: formattedCode)
        var hexValue: UInt64 = 0
        if scanner.scanHexInt64(&hexValue) {
            let red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
            let green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
            let blue = CGFloat(hexValue & 0x0000FF) / 255.0
            return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        }
        
        return nil
    }
    
    /// Gets the complementary color for a given color.
    /// - Parameter color: The color for which to find the complementary color.
    /// - Returns: The complementary color of the input color.
    public static func complementaryColor(forColor color: UIColor) -> UIColor {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let invertedR = 1.0 - r
        let invertedG = 1.0 - g
        let invertedB = 1.0 - b
        
        return UIColor(red: invertedR, green: invertedG, blue: invertedB, alpha: a)
    }

    /// Saves the color settings to a file.
    /// - Parameters:
    ///   - color: The color to save settings for.
    ///   - fileName: The name of the file to save settings to.
    /// - Throws: An error if the save operation fails.
    public static func saveColorSettings(color: UIColor, toFile fileName: String) throws {
        var hue: CGFloat = 0.0
        var saturation: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        var alpha: CGFloat = 0.0
        
        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        
        let colorSettings: [String: CGFloat] = [
            "hue": hue,
            "saturation": saturation,
            "brightness": brightness,
            "alpha": alpha
        ]
        
        guard let data = try? JSONSerialization.data(withJSONObject: colorSettings) else {
            throw NSError(domain: "ColorSerializationError", code: 0, userInfo: nil)
        }
        
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw NSError(domain: "FileDirectoryError", code: 1, userInfo: nil)
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        try data.write(to: fileURL)
    }

    /// Loads color settings from a file.
    /// - Parameter fileName: The name of the file to load color settings from.
    /// - Returns: The color loaded from the file, or nil if the file does not exist or is corrupted.
    /// - Throws: An error if the loading operation fails.
    public static func loadColorSettings(fromFile fileName: String) throws -> UIColor? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw NSError(domain: "FileDirectoryError", code: 1, userInfo: nil)
        }
        
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        guard FileManager.default.fileExists(atPath: fileURL.path) else {
            throw NSError(domain: "FileNotFoundError", code: 2, userInfo: nil)
        }
        
        guard let data = try? Data(contentsOf: fileURL),
              let colorSettings = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: CGFloat],
              let hue = colorSettings["hue"],
              let saturation = colorSettings["saturation"],
              let brightness = colorSettings["brightness"],
              let alpha = colorSettings["alpha"] else {
            throw NSError(domain: "ColorSerializationError", code: 0, userInfo: nil)
        }
        
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
    }

}

