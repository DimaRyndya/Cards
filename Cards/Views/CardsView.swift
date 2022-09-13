import SwiftUI

struct CardsView: View {
    @EnvironmentObject var viewState: ViewState
    @EnvironmentObject var store: CardStore

    var createButton: some View {
      Button(action: {
        viewState.selectedCard = store.addCard()
        viewState.showAllCards = false
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
        ZStack {
            CardsListView()
            VStack {
              Spacer()
              createButton
            }
            if !viewState.showAllCards {
                SingleCardView()
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
