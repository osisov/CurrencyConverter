//
//  CurrencyConverterAPI.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 16.12.2024.
//

import Foundation

protocol CurrencyConverterAPIProtocol: AnyObject {
    func fetchConvertedAmount(for request: ConversionRequest) async throws -> ConvertedAmount
    func fetchCurrencySymbols() async throws -> [String]
}

final class CurrencyConverterAPI: CurrencyConverterAPIProtocol {
    
    func fetchConvertedAmount(for request: ConversionRequest) async throws -> ConvertedAmount {
        try await fetchData(from: Endpoints.conversionURL(for: request))
    }
    
    func fetchCurrencySymbols() async throws -> [String] {
        let result: [String: String] = try await fetchData(from: Endpoints.currenciesURL)
        return Array(result.keys)
    }
}

private extension CurrencyConverterAPI {
    func fetchData<T: Decodable>(from urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
}

private extension CurrencyConverterAPI {
    enum Endpoints {
        static let currenciesURL = "https://openexchangerates.org/api/currencies.json"
        static func conversionURL(for request: ConversionRequest) -> String {
            return "http://api.evp.lt/currency/commercial/exchange/\(request.amount)-\(request.sourceCurrency)/\(request.targetCurrency)/latest"
        }
    }
}
