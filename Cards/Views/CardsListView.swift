import SwiftUI

struct CardsListView: View {
    @EnvironmentObject var viewState: ViewState
    @EnvironmentObject var store: CardStore

    var body: some View {
        GeometryReader { proxy in
            ScrollView(showsIndicators: false) {
                VStack {
                    LazyVGrid(columns: columns(size: proxy.size), spacing: 30) {
                        ForEach(store.cards) { card in
                            CardThumbnailView(card: card, size: proxy.size)
                                .contextMenu {
                                    Button(action: { store.remove(card) }) {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                                .onTapGesture {
                                    withAnimation {
                                      viewState.showAllCards = false
                                    }
                                    viewState.selectedCard = card
                                }
                        }
                    }
                }
            }
        }
    }
    
    func columns(size: CGSize) -> [GridItem] {
      [
        GridItem(.adaptive(
          minimum: Settings.thumbnailSize(size: size).width))
      ]
    }
}

struct CardsListView_Previews: PreviewProvider {
    static var previews: some View {
        CardsListView()
            .environmentObject(ViewState())
            .environmentObject(CardStore(defaultData: true))
    }
}


