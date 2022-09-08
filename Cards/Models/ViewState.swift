import Foundation

class ViewState: ObservableObject {

    var selectedCard: Card?

    @Published var showAllCards = true {
        didSet {
            if showAllCards {
                selectedCard = nil
            }
        }
    }

    convenience init(card: Card) {
        self.init()
        showAllCards = false
        selectedCard = card
    }

}
