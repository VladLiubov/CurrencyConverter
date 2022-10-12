//
//  CurrencyConverterApp.swift
//  CurrencyConverter
//
//  Created by Admin on 08.10.2022.
//

import SwiftUI

@main
struct CurrencyConverterApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            RootViewController(.init(state: .init()))
        }
    }
}
