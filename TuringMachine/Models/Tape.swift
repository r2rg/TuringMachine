import Foundation

struct Tape: Codable {
    var cells: [Int : String] // The tape can go both ways infinitely, so we use a dictionary for negative indices
    var index = 0
    
    mutating func write(_ symbol: String) {
        cells[index] = symbol
    }
    
    func read() -> String {
        guard let symbol = cells[index] else { return "" }
        return symbol
    }
}
