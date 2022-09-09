import SwiftUI

struct CardDetailView: View {
    @State private var currentModal: CardModal?
    @EnvironmentObject var viewState: ViewState
    @Binding var card: Card
    @State private var stickerImage: UIImage?
    @State private var images: [UIImage] = []

    var body: some View {
        content
            .onDrop(of: [.image], delegate: CardDrop(card: $card))
            .modifier(CardToolBar(currentModal: $currentModal))
            .sheet(item: $currentModal) { item in
                switch item {
                case .stickerPicker:
                    StickerPicker(stickerImage: $stickerImage)
                        .onDisappear {
                          if let stickerImage = stickerImage {
                            card.addElement(uiImage: stickerImage)
                          }
                          stickerImage = nil
                        }
                case .photoPicker:
                  PhotoPicker(images: $images)
                  .onDisappear {
                    for image in images {
                      card.addElement(uiImage: image)
                    }
                    images = []
                  }
                default:
                    EmptyView()
                }
            }

    }

    var content: some View {
        ZStack {
            card.backgroundColor
                .edgesIgnoringSafeArea(.all)
            ForEach(card.elements, id: \.id) { element in
                CardElementView(element: element)
                    .resizableView(transform: bindingTransform(for: element))
                    .frame(
                        width: element.transform.size.width,
                        height: element.transform.size.height)
                    .contextMenu {
                        Button(action: { card.remove(element) }) {
                            Label("Delete", systemImage: "trash")
                        }
                    }
            }
        }
    }

    func bindingTransform(for element: CardElement)-> Binding<Transform> {
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