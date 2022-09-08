import SwiftUI

struct Card: Identifiable {
    let id = UUID()
    var backgroundColor: Color = .yellow
    var elements: [CardElement] = []

    mutating func remove(_ element: CardElement) {
        if let index = element.index(in: elements) {
            elements.remove(at: index)
        }
    }
}

extension Card {
    func index(in array: [Card]) -> Int? {
        array.firstIndex { $0.id == id }
    }
}


