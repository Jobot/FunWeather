//
/*
 See LICENSE folder for this sample’s licensing information.
 */

import Foundation

final class FunWeatherService: WeatherProvider {
    private enum Weather: CaseIterable {
        case cloudy
        case cold
        case fantastic
        case hot
        case rainy
        case stormy
        
        var item: WeatherItem {
            WeatherItem(date: .now, degreesCelsius: temperature, conditionSymbol: symbol)
        }
        
        private var symbol: String {
            switch self {
            case .cloudy: return "cloud"
            case .cold: return "thermometer.snowflake"
            case .fantastic: return "sun.max"
            case .hot: return "thermometer.sun"
            case .rainy: return "cloud.heavyrain"
            case .stormy: return "cloud.bolt.rain"
            }
        }
        private var temperature: Double {
            switch self {
            case .cloudy: return Double.random(in: 15...25)
            case .cold: return Double.random(in: -20...10)
            case .fantastic: return Double.random(in: 20...25)
            case .hot: return Double.random(in: 30...40)
            case .rainy: return Double.random(in: 4...30)
            case .stormy: return Double.random(in: 10...30)
            }
        }
    }
    
    private var itemCache = [String:WeatherItem]()
    
    func attribution() async throws -> WeatherAttribution? {
        return nil
    }
    
    func weather(for address: String) async throws -> WeatherItem? {
        if let item = itemCache[address], !item.hasExpried {
            return item
        }
        itemCache[address] = nil
        guard let weather = Weather.allCases.randomElement() else {
            return nil
        }
        itemCache[address] = weather.item
        return weather.item
    }
}
