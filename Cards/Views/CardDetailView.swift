import SwiftUI

struct CardDetailView: View {
    @State private var currentModal: CardModal?
    @EnvironmentObject var viewState: ViewState

    var body: some View {
        content
            .modifier(CardToolBar(currentModal: $currentModal))
    }

    var content: some View {
        ZStack {
            Group {
                Capsule()
                    .foregroundColor(.yellow)
                Text("Resize Me!")
                    .fontWeight(.bold)
                    .font(.system(size: 500))
                    .minimumScaleFactor(0.01)
                    .lineLimit(1)
            }
            .resizableView()
            Circle()
                .resizableView()
                .offset(CGSize(width: 50, height: 200))
        }
    }
}

struct CardDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CardDetailView()
            .environmentObject(ViewState())
    }
}
