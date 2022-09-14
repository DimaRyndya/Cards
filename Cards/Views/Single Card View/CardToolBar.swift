import SwiftUI

struct CardToolbar: ViewModifier {
    @EnvironmentObject var viewState: ViewState
    @Binding var currentModal: CardModal?
    
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { withAnimation { viewState.showAllCards = true } }) {
                        Text("Done")
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    CardBottomToolbar(cardModal: $currentModal)
                }
            }
    }
}

