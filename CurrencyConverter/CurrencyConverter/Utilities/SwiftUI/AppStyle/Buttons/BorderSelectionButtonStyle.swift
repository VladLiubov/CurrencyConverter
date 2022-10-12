//
//  BorderSelectionButtonStyle.swift
//  Posthumously
//
//  Created by Kostiantyn Nikitchenko on 27.04.2022.
//

import Foundation
import SwiftUI

struct BorderSelectionButtonStyle: ButtonStyle {
  
  private let isRounded: Bool
  private let lineWidth: CGFloat
  private let cornerRadius: CGFloat
  private let tintColor: Color

  init(isRounded: Bool, cornerRadius: CGFloat, lineWidth: CGFloat, tintColor: Color) {
    self.isRounded = isRounded
    self.cornerRadius = cornerRadius
    self.lineWidth = lineWidth
    self.tintColor = tintColor
  }

  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .padding(.vertical, 16)
      .padding(.horizontal, 52)
      .cornerRadius(cornerRadius)
      .background(border)
      .background(Color(.clear))
  }

  var border: some View {
    RoundedRectangle(cornerRadius: isRounded ? cornerRadius : 0)
      .stroke(tintColor, lineWidth: lineWidth)
      .opacity(1)
  }
}
