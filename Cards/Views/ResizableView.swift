import SwiftUI

struct ResizableView: ViewModifier {
  @Binding var transform: Transform
  @State private var previousOffset: CGSize = .zero
  @State private var previousRotation: Angle = .zero
  @State private var scale: CGFloat = 1.0

  let viewScale: CGFloat

  init(transform: Binding<Transform>, viewScale: CGFloat = 1) {
    _transform = transform
    self.viewScale = viewScale
  }

  func body(content: Content) -> some View {
    let scaleGesture = MagnificationGesture()
      .onChanged { scale in
        self.scale = scale
      }
      .onEnded { scale in
        transform.size.width *= scale
        transform.size.height *= scale
        self.scale = 1.0
      }
    let rotationGesture = RotationGesture()
      .onChanged { rotation in
        transform.rotation += rotation - previousRotation
        previousRotation = rotation
      }
      .onEnded { _ in
        previousRotation = .zero
      }
    let dragGesture = DragGesture()
      .onChanged { value in
        transform.offset = value.translation / viewScale + previousOffset
      }
      .onEnded { _ in
        previousOffset = transform.offset
      }
    return content
      .frame(
        width: transform.size.width * viewScale,
        height: transform.size.height * viewScale)
      .rotationEffect(transform.rotation)
      .scaleEffect(scale)
      .offset(transform.offset * viewScale)
      .gesture(dragGesture)
      .gesture(SimultaneousGesture(rotationGesture, scaleGesture))
      .onAppear {
        previousOffset = transform.offset
      }
  }
}

struct ResizableView_Previews: PreviewProvider {
  static let color = Color.random()
  static let content = Rectangle()

  static var previews: some View {
    content
      .foregroundColor(color)
      .modifier(ResizableView(
        transform: .constant(Transform())))
  }
}
