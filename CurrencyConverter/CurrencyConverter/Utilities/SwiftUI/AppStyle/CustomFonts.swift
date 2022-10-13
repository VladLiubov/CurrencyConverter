//
//  CustomFonts.swift
//  CurrencyConverter
//
//  Created by Vladyslav Liubov on 08.10.2022.
//

import Foundation
import SwiftUI

enum EuclidCircularA: String, CaseIterable {
  case boldItalic = "EuclidCircularA-BoldItalic"
  case bold = "EuclidCircularA-Bold"
  case italic = "EuclidCircularA-Italic"
  case lightItalic = "EuclidCircularA-LightItalic"
  case light = "EuclidCircularA-Light"
  case mediumItalic = "EuclidCircularA-MediumItalic"
  case medium = "EuclidCircularA-Medium"
  case regular = "EuclidCircularA-Regular"
  case semiboldItalic = "EuclidCircularA-SemiBoldItalic"
  case semiBold = "EuclidCircularA-SemiBold"
  
  static func name(for weight: Font.Weight) -> String {
    switch weight {
    case .ultraLight, .thin, .light:
      return Self.light.rawValue
    case .regular:
      return Self.regular.rawValue
    case .medium:
      return Self.medium.rawValue
    case .semibold:
      return Self.semiBold.rawValue
    case .heavy, .black, .bold:
      return Self.bold.rawValue
    default:
      return Self.regular.rawValue
    }
  }
}

extension UIFont {
  /// Returns a new font in the same family with the given symbolic traits,
  /// or `nil` if none found in the system.
  private func withSymbolicTraits(_ traits: UIFontDescriptor.SymbolicTraits) -> UIFont? {
    guard let descriptorWithTraits = fontDescriptor.withSymbolicTraits(traits)
    else { return nil }
    return UIFont(descriptor: descriptorWithTraits, size: 0)
  }
  
  public func bold() -> UIFont? {
    withSymbolicTraits(.traitBold)
  }
}

public struct Fonts {
  public static func configure() {
    EuclidCircularA.allCases.forEach {
      registerFont(bundle: .main, fontName: $0.rawValue, fontExtension: "ttf")
    }
  }
  
  private static func registerFont(bundle: Bundle, fontName: String, fontExtension: String) {
    guard let fontURL = bundle.url(forResource: fontName, withExtension: fontExtension),
          let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
          let font = CGFont(fontDataProvider)
    else {
      fatalError("Couldn't create font from filename: \(fontName) with extension \(fontExtension)")
    }
    
    var error: Unmanaged<CFError>?
    
    CTFontManagerRegisterGraphicsFont(font, &error)
  }
}

public struct EuclidCircularAFontModifier: ViewModifier {
  var size: CGFloat
  var weight: Font.Weight
  
  public init(size: CGFloat = 13, weight: Font.Weight = .regular) {
    self.size = size
    self.weight = weight
  }
  
  public func body(content: Content) -> some View {
    content
      .font(
        Font.custom(
          EuclidCircularA.name(for: weight),
          size: size
        )
      )
  }
}

