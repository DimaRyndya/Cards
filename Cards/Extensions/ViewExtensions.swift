import SwiftUI

extension View {
    func resizableView() -> some View {
        return modifier(ResizableView())
    }
}


