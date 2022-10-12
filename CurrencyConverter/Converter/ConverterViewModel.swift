//
//  ConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Admin on 08.10.2022.
//

import Combine
import SwiftUI

class RootViewModel: BaseViewModel<RootViewModel.State, RootViewModel.Action, Never> {
  
  enum Action {
  
  }
  
  struct State: AnyState {
    
    enum Screen: Equatable {
      case camera
      case photoGallery
      case search
    }
    
    public fileprivate(set) var showedScreen: Screen?
    public fileprivate(set) var recognizedWords: [String] = []
    
    init() {}
    
  }
  
  override func action(_ action: Action) {
    switch action {
          
    }
  }
}
