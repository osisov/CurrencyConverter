//
//  CurrencyConverterAPI.swift
//  CurrencyConverter
//
//  Created by Aleksandr Sisov on 16.12.2024.
//

import Foundation

protocol CurrencyConverterAPIProtocol: AnyObject {
    func fetchConvertedAmount(for request: ConversionRequest) async throws -> ConvertedAmount
    func fetchAvailableCurrencies() async throws -> [String]
}

final class CurrencyConverterAPI: CurrencyConverterAPIProtocol {
    
    func fetchConvertedAmount(for request: ConversionRequest) async throws -> ConvertedAmount {
        let urlString = Endpoints.conversionURL(for: request)
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        
        let decodedResponse = try JSONDecoder().decode(ConvertedAmount.self, from: data)
        return decodedResponse
    }
    
    func fetchAvailableCurrencies() async throws -> [String] {
        return [
            "USD",
            "EUR",
            "UAH",
            "PZL"
        ]
    }
}

private extension CurrencyConverterAPI {
    enum Endpoints {
        static func conversionURL(for request: ConversionRequest) -> String {
            return "http://api.evp.lt/currency/commercial/exchange/\(request.amount)-\(request.sourceCurrency)/\(request.targetCurrency)/latest"
        }
    }
}
