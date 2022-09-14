import SwiftUI

struct AppLoadingView: View {
    @State private var showSplash = true

    var body: some View {
        if showSplash {
            SplashScreen()
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        withAnimation {
                            showSplash = false
                        }
                    }
                }
                .transition(.scale(scale: 0, anchor: .top))
        } else {
            CardsView()
        }
    }
}

struct AppLoadingView_Previews: PreviewProvider {
    static var previews: some View {
        AppLoadingView()
            .environmentObject(CardStore(defaultData: true))
    }
}
