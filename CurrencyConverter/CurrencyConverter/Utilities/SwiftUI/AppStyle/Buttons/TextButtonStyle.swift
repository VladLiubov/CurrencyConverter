//
//  TextButtonStyle.swift
//  CurrencyConverter
//
//  Created by Vladyslav Liubov on 08.10.2022.
//

import Foundation
import SwiftUI

struct TextButtonStyle: ButtonStyle {
  private let tintColor: Color

  public init(tintColor: Color) {
    self.tintColor = tintColor
  }

  public func makeBody(configuration: Configuration) -> some View {
    WrapperButton(tintColor: tintColor, configuration: configuration)
  }

  struct WrapperButton: View {

    let tintColor: Color
    let configuration: ButtonStyle.Configuration

    @Environment(\.isEnabled) private var isEnabled: Bool

    var body: some View {
      configuration.label
        .font(.headline)
        .foregroundColor(textColor)
        .padding(.vertical, 16)
        .padding(.horizontal, 32)
        .multilineTextAlignment(.leading)
    }

    var textColor: Color {
      isEnabled ? tintColor : Color(.gray)
    }

  }
}

#if DEBUG
struct TextButton_Previews: PreviewProvider {
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
    .disabled(!isEnabled)
    .padding()
    .buttonStyle(TextButtonStyle(tintColor: Color(.blue)))
  }
}
#endif
