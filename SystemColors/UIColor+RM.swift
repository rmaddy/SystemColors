//
//  UIColor+RM.swift
//  SystemColors
//
//  Created by Richard W Maddy on 6/4/19.
//  Copyright © 2019 Richard W Maddy. All rights reserved.
//

import UIKit

extension UIColor {
    // Convert the RGBA color to a hexcode. If the color is a grayscale, treat it as WWWA
    func hexCode() -> String {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {

        } else {
            var white: CGFloat = 0
            if getWhite(&white, alpha: &alpha) {
                red = white
                green = white
                blue = white
            } else {
                return "#XXXXXX"
            }
        }

        return String(format: "#%02X%02X%02X%02X", Int(red * 255), Int(green * 255), Int(blue * 255), Int(alpha * 255))
    }

    // Get the grayscale of the color. It's dark if <= 0.5, light if > 0.5
    var isLightColor: Bool {
        var white: CGFloat = 0
        if getWhite(&white, alpha: nil) {
            return white > 0.5
        }

        return false
    }

    // This determines the resulting color of drawing all of the colors over each other.
    static func combine(colors: [UIColor]) -> UIColor {
        guard !colors.isEmpty else { return .clear }

        // If color isn't transparent, simply return that color
        if colors.last!.cgColor.alpha == 1 {
            return colors.last!
        }

        // Create a little image context. Fill it with self then fill it with color
        // Look at the resulting pixel in the middle and return that color with no alpha
        // NOTE: There must be an easier way to do this
        let width = 4
        let height = 4
        let bitmapBytesPerRow = 4 * width
        let bitmapByteCount = bitmapBytesPerRow * height
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapData = malloc(bitmapByteCount)!
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)
        //UIGraphicsBeginImageContextWithOptions(size, true, 1)
        let context = CGContext(data: bitmapData, width: width, height: height, bitsPerComponent: 8, bytesPerRow: bitmapBytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!

        let rect = CGRect(x: 0, y: 0, width: width, height: height)
        for color in colors {
            context.setFillColor(color.cgColor)
            context.fill(rect)
        }

        let offset = 4 * (2 * width + 2)

        let red = bitmapData.load(fromByteOffset: offset + 1, as: UInt8.self)
        let green = bitmapData.load(fromByteOffset: offset + 2, as: UInt8.self)
        let blue = bitmapData.load(fromByteOffset: offset + 3, as: UInt8.self)

        free(bitmapData)

        return UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
    }
}
