import SwiftUI
import PencilKit

struct PancilCanvasView: View {
    @State private var canvas = PKCanvasView()
    var body: some View {
        RepresentableObject(canvas: $canvas)
    }
}

struct RepresentableObject: UIViewRepresentable {
    @Binding var canvas: PKCanvasView
    
    func makeUIView(context: Context) -> some UIView {
        canvas.drawingPolicy = PKCanvasViewDrawingPolicy.anyInput
        return canvas
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

struct PancilCanvasView_Previews: PreviewProvider {
    static var previews: some View {
        PancilCanvasView()
    }
}
