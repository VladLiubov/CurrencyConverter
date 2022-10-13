//
//  ConverterView.swift
//  CurrencyConverter
//
//  Created by Vladyslav Liubov on 08.10.2022.
//

import SwiftUI
import Combine

extension ConverterViewController {
  
  struct ContainerView: View {
   
    @ObservedObject var viewModel: ViewModel
      
    init(_ viewModel: ViewModel) {
      self._viewModel = .init(initialValue: viewModel)
    }
    
      public var body: some View {
          
          //SellBinding
          let bindingSellInput = Binding<String> (
            get: { viewModel.state.sell},
            set: { viewModel.action(.updateSellInput($0))}
          )
          
          let bindingSelectedSellInput = Binding<ViewModel.CurrencyCategories> (
            get: { viewModel.state.selectedSellCurrency},
            set: { viewModel.action(.updateSelectedSellInput($0))}
          )
          
          //ReceiveBinding
          let bindingReciveInput = Binding<String> (
            get: { viewModel.state.receive},
            set: { viewModel.action(.updateReceiveInput($0))}
          )
          
          let bindingSelectedReciveInput = Binding<ViewModel.CurrencyCategories> (
            get: { viewModel.state.selectedReceiveCurrency},
            set: { viewModel.action(.updateSelectedReceivelInput($0))}
          )
          
          //Alert
          let bindingAlertSuccsesInput = Binding<Bool> (
            get: { viewModel.state.showAlert},
            set: { viewModel.action(.updateAlert($0))}
          )
          
          VStack(alignment: .leading) {
              
              Text("MY BALANCES")
                  .font(.caption2)
                  .multilineTextAlignment(.leading)
                  .padding(.top, 20)
              
              HStack(alignment: .center, spacing: 20) {
                  balanceUSD
                  balanceEUR
                  balanceJPY
              }
              .frame(minWidth: 0, maxWidth: .infinity)
              .padding(.top, 20)
              
              Text("CURRENCY EXCHANGE")
                  .font(.caption2)
                  .multilineTextAlignment(.leading)
                  .padding(.top, 20)
              
              // Sell View
              HStack(spacing: 8) {
                 
                  Image(systemName: "chevron.up.circle.fill")
                      .resizable()
                      .foregroundColor(Color.red)
                      .frame(width: 30.0, height: 30.0)
                  
                  Text("Sell")
                  
                  Spacer()
                  
                  TextField("", text: bindingSellInput)
                      .frame(alignment: .trailing)
                      .padding(.leading, 40)
                      .keyboardType(.decimalPad)
                      .onTapGesture {
                          bindingSellInput.wrappedValue = ""
                      }
                      .onChange(of: bindingSellInput.wrappedValue) { _ in
                          if bindingSellInput.wrappedValue.isEmpty {
                              bindingReciveInput.wrappedValue = "0"
                          } else {
                            viewModel.getConverter()
                        }
                      }

                      Picker("Picker", selection: bindingSelectedSellInput) {
                          ForEach(ConverterViewController.ViewModel.CurrencyCategories.allCases) { category in
                              Text(category.name)
                                  .tag(category)
                          }
                      }
              }
              .padding(.horizontal, 6)
              .padding(.top, 20)
               Divider()
              
              //Receive View
              HStack(spacing: 8) {
                 
                  Image(systemName: "chevron.down.circle.fill")
                      .resizable()
                      .foregroundColor(Color.blue)
                      .frame(width: 30.0, height: 30.0)
                  
                  Text("Receive")
                  
                  Text("\(bindingReciveInput.wrappedValue)")
                      .foregroundColor(Color.green)
                      .padding(.leading, 26)
                  
                  Spacer()
                  
                  Picker("Picker", selection: bindingSelectedReciveInput) {
                      ForEach(ConverterViewController.ViewModel.CurrencyCategories.allCases) { category in
                        Text(category.name)
                           .tag(category)
                    }
                }
              }
              .padding(.horizontal, 6)
              .padding(.top, 20)
              Divider()
              
              //Submit Button
              Button {
                  viewModel.action(.submitButton)
              } label: {
                 Text("SUBMIT")
                    .customStyled(as: .mainButton)
                    .frame(minWidth: 0, maxWidth: .infinity)
              }
              .styled(as: .mainButton(cornerRadius: 25, tintColor: viewModel.state.sell != "" && viewModel.state.sell != "0" ? Color.blue : Color.gray))
              .padding(.top, 30)
              Spacer()
        }
         .padding(.horizontal, 12)
         .alert(isPresented: bindingAlertSuccsesInput) {
             Alert(
                title: Text("Currency Converted"),
                message: Text(ChosenMessage(selectMessage: viewModel.state.selectedMessage, viewModel: viewModel).body),
                dismissButton: .default(Text("OK"), action: {
                 bindingAlertSuccsesInput.wrappedValue = false
                 bindingSellInput.wrappedValue = ""
                 bindingReciveInput.wrappedValue = "0"
             }))
        }
    }
      var balanceEUR: some View {
          let bindingEURInput = Binding<Double> (
            get: { viewModel.state.EUR},
            set: { viewModel.action(.updateEURInput($0))}
          )
          return VStack(alignment: .leading) {
              HStack{
                  Text("\(bindingEURInput.wrappedValue.formatted()) EUR")
              }
          }
      }
      
      var balanceUSD: some View {
          let bindingUSDInput = Binding<Double> (
            get: { viewModel.state.USD},
            set: { viewModel.action(.updateUSDInput($0))}
          )
          return VStack(alignment: .leading) {
              Text("\(bindingUSDInput.wrappedValue.formatted()) USD")
          }
      }
      
      var balanceJPY: some View {
          let bindingJPYInput = Binding<Double> (
            get: { viewModel.state.JPY},
            set: { viewModel.action(.updateJPYInput($0))}
          )
          return VStack(alignment: .leading) {
              Text("\(bindingJPYInput.wrappedValue.formatted()) JPY")
          }
      }
  }
}
