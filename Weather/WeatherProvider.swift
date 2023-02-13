import Foundation

protocol WeatherProvider {
    func attribution() async throws -> WeatherAttribution?
    func weather(for address: String) async throws -> WeatherItem?
}

extension WeatherProvider {
    var locationCache: LocationCache { LocationCache.shared }
}

struct WeatherItem: Hashable {
    let date: Date
    let degreesCelsius: Double
    let conditionSymbol: String
    
    var temperature: Measurement<UnitTemperature> {
        Measurement(value: degreesCelsius, unit: .celsius)
    }
    var hasExpried: Bool {
        abs(date.timeIntervalSinceNow) > expirationInterval
    }
    
    private var expirationInterval: TimeInterval { 600 } // 5 minutes
}

struct WeatherAttribution {
    let darkSchemeURL: URL
    let lightSchemeURL: URL
    let legalURL: URL?
}
