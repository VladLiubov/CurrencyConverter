//
//  MainButtonStyle.swift
//  CurrencyConverter
//
//  Created by Vladyslav Liubov on 08.10.2022.
//

import Foundation
import SwiftUI

struct MainButtonStyle: ButtonStyle {
  private let cornerRadius: CGFloat
  private let tintColor: Color

  public init(cornerRadius: CGFloat, tintColor: Color) {
    self.cornerRadius = cornerRadius
    self.tintColor = tintColor
  }

  func makeBody(configuration: Configuration) -> some View {
    WrapperButton(cornerRadius: cornerRadius, tintColor: tintColor, configuration: configuration)
  }

  struct WrapperButton: View {

    let cornerRadius: CGFloat
    let tintColor: Color
    let configuration: ButtonStyle.Configuration

    @Environment(\.isEnabled) private var isEnabled: Bool

    var body: some View {
      configuration.label
        .font(.headline)
        .foregroundColor(textColor)
        .padding(.vertical, 16)
        .padding(.horizontal, 48)
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .background(border)
    }

    var textColor: Color {
      isEnabled ? .white : tintColor
    }

    var backgroundColor: Color {
        isEnabled ? tintColor : .init(Color(.gray) as! CGColor)
    }

    var border: some View {
      RoundedRectangle(cornerRadius: cornerRadius)
        .stroke(tintColor, lineWidth: 4)
        .opacity(isEnabled ? 0 : 1)
    }

  }
}

#if DEBUG
struct MainButtonStyle_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      VStack {
        makeButton(true)
        makeButton(false)
      }

      VStack {
        makeButton(true)
        makeButton(false)
      }.preferredColorScheme(.dark)
    }
  }

  @ViewBuilder
  static func makeButton(_ isEnabled: Bool) -> some View {
    Button("Some text") {

    }.frame(height: 44)
     .padding()
     .disabled(!isEnabled)
     .buttonStyle(MainButtonStyle(
      cornerRadius: 8,
      tintColor: Color(.blue))
     )
  }
}
#endif
