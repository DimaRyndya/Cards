import SwiftUI

struct CardsView: View {
    @EnvironmentObject var viewState: ViewState
    @EnvironmentObject var store: CardStore

    var createButton: some View {
      Button(action: {
        viewState.selectedCard = store.addCard()
        withAnimation {
          viewState.showAllCards = false
        }

      }) {
        Label("Create New", systemImage: "plus")
            .frame(maxWidth: .infinity)
      }
      .font(.system(size: 16, weight: .bold))
      .padding([.top, .bottom], 10)
      .background(Color("barColor"))
      .accentColor(.white)
    }

    var body: some View {
        VStack {
            if viewState.showAllCards {
              ListSelectionView(selection: $viewState.cardListState)
            }

            ZStack {
                switch viewState.cardListState {
                case .list:
                  CardsListView()
                case .carousel:
                  Carousel()
                }
                VStack {
                  Spacer()
                  createButton
                }
                if !viewState.showAllCards {
                    SingleCardView()
                        .zIndex(1)
                }
            }
        }
    }
}

struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        CardsView()
            .environmentObject(ViewState())
            .environmentObject(CardStore(defaultData: true))
    }
}
