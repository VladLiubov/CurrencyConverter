//
//  APIServise.swift
//  CurrencyConverter
//
//  Created by Admin on 08.10.2022.
//

import Foundation
import UIKit
import SwiftUI
import Combine

class APIService {
    
    static let shared = APIService()
    static let url = "https://api.apilayer.com/fixer/latest?symbols={symbols}&base={base}"
    
    static func get(for request: URLRequest) -> AnyPublisher<Currency, Error>  {
        URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: Currency.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
    
struct ConversionService {
    
    static func getConversion(amount: String, fromCurrency: String, toCurrency: String) -> AnyPublisher<Currency, Error> {
        
        let url = "http://api.evp.lt/currency/commercial/exchange/\(amount)-\(fromCurrency)/\(toCurrency)/latest"

        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "GET"
        
        return APIService
            .get(for: request)
    }
}
