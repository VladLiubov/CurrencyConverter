//
//  AppStyle.swift
//  CurrencyConverter
//
//  Created by Vladyslav Liubov on 08.10.2022.
//

import SwiftUI

enum AppStyle {
  public enum Font: CGFloat {
    case title = 30
    case headline = 17
    case body = 13
    case small = 11
    case tiny = 9
  }
  
  enum Button {
    case text(tintColor: Color)
    case mainButton(cornerRadius: CGFloat, tintColor: Color = Color.gray)
    case borderSelection(isRounded: Bool = true,
                         cornerRadius: CGFloat = 32,
                         lineWidth: CGFloat = 2,
                         tintColor: Color = Color(.darkGray))
    
    @ViewBuilder
    internal func apply<ButtonView: SwiftUI.View>(to button: SwiftUI.Button<ButtonView>) -> some SwiftUI.View {
      switch self {
      case let .text(tintColor):
        button.buttonStyle(TextButtonStyle(tintColor: tintColor))
      case let .mainButton(cornerRadius, tintColor):
        button.buttonStyle(MainButtonStyle(cornerRadius: cornerRadius, tintColor: tintColor))
      case let .borderSelection(isRounded, cornerRadius, lineWidth, tintColor):
        button.buttonStyle(BorderSelectionButtonStyle(isRounded: isRounded,
                                                      cornerRadius: cornerRadius,
                                                      lineWidth: lineWidth,
                                                      tintColor: tintColor))
      }
    }
  }
  
  enum Text {
    case header
    case title
    case subtitle
    case body
    case mainButton
    case borderPlaceholder
    case textFieldError
    case menuItem
    case menuItemRed
    case link
    case smallTitle
    case smallSubtitle
    case tinyTitle
    case tinySubtitle

    var fontStyle: AppStyle.Font {
      switch self {
      case .header, .title:
        return .title
      case .subtitle, .body, .mainButton, .menuItem, .menuItemRed:
        return .headline
      case .borderPlaceholder, .textFieldError, .link:
        return .body
      case .smallTitle, .smallSubtitle:
        return .small
      case .tinyTitle, .tinySubtitle:
        return .tiny
      }
    }

    // TODO: - Think of better merging between UIKit and SwiftUI
    // Need to think more about having model to clear seperation (exp. color.uiKit, color.swiftUI)

    var foregroundColor: Color {
      switch self {
      case .header, .body, .mainButton, .title, .menuItem, .smallSubtitle, .tinyTitle, .smallTitle, .tinySubtitle:
        return Color.white
      case .subtitle:
        return Color(.gray)
      case .borderPlaceholder, .textFieldError:
        return Color(.darkGray)
      case .menuItemRed:
        return Color(.red)
      case .link:
        return Color(.blue)
      }
    }

    var uiForegroundColor: UIColor {
      switch self {
      case .header, .body, .mainButton, .title, .menuItem, .tinyTitle, .smallTitle, .smallSubtitle, .tinySubtitle:
        return UIColor.white
      case .subtitle:
        return UIColor(Color.gray)
      case .borderPlaceholder, .textFieldError:
        return UIColor(Color.gray)
      case .menuItemRed:
        return UIColor(Color.red)
      case .link:
        return UIColor(Color.blue)
      }
    }

    var weight: SwiftUI.Font.Weight {
      switch self {
      case .header, .body, .mainButton, .borderPlaceholder, .smallTitle, .tinyTitle:
        return .semibold
      case .subtitle, .textFieldError, .menuItem, .menuItemRed:
        return .regular
      case .title:
        return .medium
      case .link, .smallSubtitle, .tinySubtitle:
        return .light
      }
    }

    var uiWeight: UIFont.Weight {
      switch self {
      case .header, .body, .mainButton, .borderPlaceholder, .smallTitle, .tinyTitle:
        return .semibold
      case .subtitle, .textFieldError, .menuItem, .menuItemRed:
        return .regular
      case .title:
        return .medium
      case .link, .smallSubtitle, .tinySubtitle:
        return .light

      }
    }

    var uiFont: UIFont {
      UIFont.systemFont(ofSize: fontStyle.rawValue, weight: uiWeight)
    }

    internal func apply(to text: SwiftUI.Text) -> some SwiftUI.View {
      text
        .font(.system(size: fontStyle.rawValue, weight: weight))
        .foregroundColor(foregroundColor)
    }
    
    internal func applyCustomFont(to text: SwiftUI.Text) -> some SwiftUI.View {
      text
        .customFont(style: fontStyle, weight: weight)
        .foregroundColor(foregroundColor)
    }
  }
}

// MARK: - Button Style extensions

extension Button {

  func styled(as style: AppStyle.Button) -> some View {
    style.apply(to: self)
  }

}

// MARK: - Text Style extensions

extension Text {

  func styled(as style: AppStyle.Text) -> some View {
    style.apply(to: self)
  }
  
  func customStyled(as style: AppStyle.Text) -> some View {
    style.applyCustomFont(to: self)
  }

  private func bold(isApplied: Bool) -> Text {
    isApplied ? self.bold() : self
  }

}

// MARK: - Font Style extensions

extension View {

  func customFont(style: AppStyle.Font = .body, weight: Font.Weight = .regular) -> some View {
    self.modifier(EuclidCircularAFontModifier(size: style.rawValue, weight: weight))
  }

}
