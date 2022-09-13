import SwiftUI


struct CardDetailView: View {
  @EnvironmentObject var viewState: ViewState
  @Environment(\.scenePhase) private var scenePhase
  @State private var currentModal: CardModal?
  @Binding var card: Card

  var body: some View {
    content
      .onChange(of: scenePhase) { newScenePhase in
        if newScenePhase == .inactive {
          card.save()
        }
      }
      .onDisappear {
        card.save()
      }
      .onDrop(of: [.image], delegate: CardDrop(card: $card))
      .modifier(CardToolbar(currentModal: $currentModal))
      .cardModals(card: $card, currentModal: $currentModal)
  }

  var content: some View {
    ZStack {
      card.backgroundColor
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
          viewState.selectedElement = nil
        }
      ForEach(card.elements, id: \.id) { element in
        CardElementView(
          element: element,
          selected: viewState.selectedElement?.id == element.id)
          .contextMenu {
            // swiftlint:disable:next multiple_closures_with_trailing_closure
            Button(action: { card.remove(element) }) {
              Label("Delete", systemImage: "trash")
            }
          }
          .resizableView(transform: bindingTransform(for: element))
          .frame(
            width: element.transform.size.width,
            height: element.transform.size.height)
          .onTapGesture {
            viewState.selectedElement = element
          }
      }
    }
  }

  func bindingTransform(for element: CardElement)
    -> Binding<Transform> {
    guard let index = element.index(in: card.elements) else {
      fatalError("Element does not exist")
    }
    return $card.elements[index].transform
  }
}

struct CardDetailView_Previews: PreviewProvider {
  struct CardDetailPreview: View {
    @State private var card = initialCards[0]
    var body: some View {
      CardDetailView(card: $card)
        .environmentObject(ViewState(card: card))
    }
  }
  static var previews: some View {
    CardDetailPreview()
  }
}
