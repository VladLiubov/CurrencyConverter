//
//  SwiftUIView.swift
//  CurrencyConverter
//
//  Created by Admin on 08.10.2022.
//

import Foundation
import SwiftUI

struct SwiftUIView<ViewController: UIViewController>: UIViewControllerRepresentable {
  typealias UIViewControllerType = ViewController

  private let viewController: ViewController

  init(viewController: ViewController) {
    self.viewController = viewController
  }

  func makeUIViewController(context: Context) -> ViewController {
    viewController
  }

  func updateUIViewController(_ uiViewController: ViewController, context: Context) {}

}
