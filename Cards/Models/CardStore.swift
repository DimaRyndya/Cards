import SwiftUI

class CardStore: ObservableObject {
    @Published var cards: [Card] = []
}
