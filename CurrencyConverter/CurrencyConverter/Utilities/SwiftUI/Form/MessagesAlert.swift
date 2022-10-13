//
//  Messages.swift
//  CurrencyConverter
//
//  Created by Vladyslav Liubov on 08.10.2022.
//

import Foundation

enum Messages: String, CaseIterable {
    case free = "Free"
    case commission = "Comission"
    case failure = "Failure"
}


struct ChosenMessage {
    var selectMessage: Messages
    var viewModel: ConverterViewModel
    
    var body: String {
        switch selectMessage {
        case .free:
            return String("You have converted \(viewModel.state.sell) \(viewModel.state.selectedSellCurrency.name) to \(viewModel.state.receive) \(viewModel.state.selectedReceiveCurrency.name).")
        case .commission:
            return String("You have converted \(viewModel.state.sell) \(viewModel.state.selectedSellCurrency.name) to \(viewModel.state.receive) \(viewModel.state.selectedReceiveCurrency.name). Commision Fee - \(viewModel.state.commission) \(viewModel.state.selectedSellCurrency.name)")
        case .failure:
           return String("You don't have enough \(viewModel.state.selectedSellCurrency.name) to convert")
        }
    }
}
