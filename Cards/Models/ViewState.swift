import SwiftUI

enum CardListState {
  case list, carousel
}

class ViewState: ObservableObject {
  @Published var showAllCards = true {
    didSet {
      if showAllCards {
        selectedCard = nil
      }
    }
  }
  @Published var selectedElement: CardElement?

  var selectedCard: Card? {
    didSet {
      if selectedCard == nil {
        selectedElement = nil
      }
    }
  }

  convenience init(card: Card) {
    self.init()
    showAllCards = false
    selectedCard = card
    selectedElement = nil
  }

  // Determines which view to show in `CardsListView`
  @Published var cardListState: CardListState = .list

  // For sharing the card with a screenshot - see `RenderableView`
  var shouldScreenshot = false
}

