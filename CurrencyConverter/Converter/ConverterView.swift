//
//  ConverterView.swift
//  CurrencyConverter
//
//  Created by Admin on 08.10.2022.
//

import SwiftUI
import Combine

extension RootViewController {
  
  struct ContainerView: View {
   
    @ObservedObject var viewModel: ViewModel
    
    init(_ viewModel: ViewModel) {
      self._viewModel = .init(initialValue: viewModel)
    }
    
      public var body: some View {
          VStack{
              Text("Hi")
      }
    }
  }
}
