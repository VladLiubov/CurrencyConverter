//
//  ConverterViewModel.swift
//  CurrencyConverter
//
//  Created by Admin on 08.10.2022.
//

import Combine
import SwiftUI

class RootViewModel: BaseViewModel<RootViewModel.State, RootViewModel.Action, Never> {
  
    
  enum CurrencyCategories: String, CaseIterable, Identifiable {
     case EUR, USD, JPY
        
     var id: Self { self }
        
        var name: String {
            switch self {
            case .EUR: return "EUR"
            case .USD: return "USD"
            case .JPY: return "JPY"
            }
        }
    }
    
  enum Action {
    //Balance
    case updateUSDInput(Double)
    case updateEURInput(Double)
    case updateJPYInput(Double)
    //Operations
    case updateSellInput(String)
    case updateReceiveInput(String)
    //Selected
    case updateSelectedSellInput(CurrencyCategories)
    case updateSelectedReceivelInput(CurrencyCategories)
    //Convert
    case submitButton
    //Alert
    case updateAlert(Bool)
  }
  
    struct State: AnyState {
        static func == (lhs: RootViewModel.State, rhs: RootViewModel.State) -> Bool {
            true
        }
    
    enum Screen: Equatable {
    }
      //Screen
      public fileprivate(set) var showedScreen: Screen?
      //Balance
      public fileprivate(set) var USD: Double = 0
      public fileprivate(set) var EUR: Double = 1000
      public fileprivate(set) var JPY: Double = 0
      //Operations
      public fileprivate(set) var sell: String = "0"
      public fileprivate(set) var receive: String = "0"
      public fileprivate(set) var count: Int = 1
      public fileprivate(set) var commission: Double = 0
      //Selected
      public fileprivate(set) var selectedSellCurrency: CurrencyCategories = .EUR
      public fileprivate(set) var selectedReceiveCurrency: CurrencyCategories = .USD
      public fileprivate(set) var selectedMessage: Messages = .failure
      //Alert
      public fileprivate(set) var showAlert = false
        
    init() {}
    
  }
  
  override func action(_ action: Action) {
      switch action {
          //Balance
      case let .updateUSDInput(input):
          state.showedScreen = nil
          state.USD = input
      case let .updateEURInput(input):
          state.showedScreen = nil
          state.EUR = input
      case let .updateJPYInput(input):
          state.showedScreen = nil
          state.JPY = input
          //Operations
      case let .updateSellInput(input):
          state.showedScreen = nil
          let sell = input.components(separatedBy: ",")
          state.sell = sell.joined(separator: ".")
          if state.sell == "" {
              state.receive = "0"
          }
      case let .updateReceiveInput(input):
          state.showedScreen = nil
          state.receive = input
          //Selected
      case let .updateSelectedSellInput(input):
          state.showedScreen = nil
          state.selectedSellCurrency = input
          getConverter()
      case let .updateSelectedReceivelInput(input):
          state.showedScreen = nil
          state.selectedReceiveCurrency = input
          getConverter()
          //Convert
      case .submitButton:
          guard state.sell != "" && state.receive != "" && state.selectedReceiveCurrency.name != state.selectedSellCurrency.name else { return }
          //USD
          if state.selectedSellCurrency.name == CurrencyCategories.USD.name {
              if state.USD <= Double(state.sell)! {
                  self.state.selectedMessage = .failure
                  self.state.showAlert = true
              } else {
                  if state.count <= 5 {
                      //Free
                      state.USD -= Double(state.sell)!
                      if state.selectedReceiveCurrency.name == CurrencyCategories.EUR.name {
                          state.EUR += Double(state.receive)!
                          state.count += 1
                          self.state.selectedMessage = .free
                          self.state.showAlert = true
                      } else if state.selectedReceiveCurrency.name == CurrencyCategories.JPY.name {
                          state.JPY += Double(state.receive)!
                          state.count += 1
                          self.state.selectedMessage = .free
                          self.state.showAlert = true
                      }
                  } else {
                      //Comission
                      state.commission = Double(state.sell)! * 0.7 / 100
                      if state.USD <= Double(state.sell)! + Double(state.commission) {
                          self.state.selectedMessage = .failure
                          self.state.showAlert = true
                      } else {
                          state.USD -= Double(state.sell)! + Double(state.commission)
                          if state.selectedReceiveCurrency.name == CurrencyCategories.EUR.name {
                              state.EUR += Double(state.receive)!
                              self.state.selectedMessage = .commission
                              self.state.showAlert = true
                          } else if state.selectedReceiveCurrency.name == CurrencyCategories.JPY.name {
                              state.JPY += Double(state.receive)!
                              self.state.selectedMessage = .commission
                              self.state.showAlert = true
                          }
                      }
                  }
              }
              //EUR
          } else if state.selectedSellCurrency.name == CurrencyCategories.EUR.name {
              if state.EUR <= Double(state.sell)! {
                  self.state.selectedMessage = .failure
                  self.state.showAlert = true
              } else {
                  if state.count <= 5 {
                      //Free
                      state.EUR -= Double(state.sell)!
                      if state.selectedReceiveCurrency.name == CurrencyCategories.USD.name {
                          state.USD += Double(state.receive)!
                          state.count += 1
                          self.state.selectedMessage = .free
                          self.state.showAlert = true
                      } else if state.selectedReceiveCurrency.name == CurrencyCategories.JPY.name {
                          state.JPY += Double(state.receive)!
                          state.count += 1
                          self.state.selectedMessage = .free
                          self.state.showAlert = true
                      }
                  } else {
                      //Comission
                      state.commission = Double(state.sell)! * 0.7 / 100
                      if state.EUR <= Double(state.sell)! + Double(state.commission) {
                          self.state.selectedMessage = .failure
                          self.state.showAlert = true
                      } else {
                          state.EUR -= Double(state.sell)! + Double(state.commission)
                          if state.selectedReceiveCurrency.name == CurrencyCategories.USD.name {
                              state.USD += Double(state.receive)!
                              self.state.selectedMessage = .commission
                              self.state.showAlert = true
                          } else if state.selectedReceiveCurrency.name == CurrencyCategories.JPY.name {
                              state.JPY += Double(state.receive)!
                              self.state.selectedMessage = .commission
                              self.state.showAlert = true
                          }
                      }
                  }
              }
              //JPY
          } else if state.selectedSellCurrency.name == CurrencyCategories.JPY.name {
              if state.JPY <= Double(state.sell)! {
                  self.state.selectedMessage = .failure
                  self.state.showAlert = true
              } else {
                  if state.count <= 5 {
                      //Free
                      state.JPY -= Double(state.sell)!
                      if state.selectedReceiveCurrency.name == CurrencyCategories.USD.name {
                          state.USD += Double(state.receive)!
                          state.count += 1
                          self.state.selectedMessage = .free
                          self.state.showAlert = true
                      } else if state.selectedReceiveCurrency.name == CurrencyCategories.EUR.name{
                          state.EUR += Double(state.receive)!
                          state.count += 1
                          self.state.selectedMessage = .free
                          self.state.showAlert = true
                      }
                  } else {
                      //Comission
                      state.commission = Double(state.sell)! * 0.7 / 100
                      if state.JPY <= Double(state.sell)! + Double(state.commission) {
                          self.state.selectedMessage = .failure
                          self.state.showAlert = true
                      } else {
                          state.JPY -= Double(state.sell)! + Double(state.commission)
                          if state.selectedReceiveCurrency.name == CurrencyCategories.USD.name {
                              state.USD += Double(state.receive)!
                              self.state.selectedMessage = .commission
                              self.state.showAlert = true
                          } else if state.selectedReceiveCurrency.name == CurrencyCategories.EUR.name {
                              state.EUR += Double(state.receive)!
                              self.state.selectedMessage = .commission
                              self.state.showAlert = true
                          }
                      }
                  }
              }
          }
          //Alert
      case let .updateAlert(input):
          state.showAlert = input
      }
  }

    func getConverter() {
        ConversionService
            .getConversion(amount: state.sell, fromCurrency: state.selectedSellCurrency.name, toCurrency: state.selectedReceiveCurrency.name)
            .receive(on: RunLoop.main)
            .sink { (completion) in
                switch completion {
                case .failure(let error):
                    print(error.localizedDescription)
                    return
                case .finished:
                    return
                }
            } receiveValue: { [weak self] (result) in
                self?.state.receive = result.amount
            }
            .store(in: &cancellables)
    }
}
