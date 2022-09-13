import SwiftUI

struct TextPicker: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var textElement: TextElement
    
    var body: some View {
        let onCommit = {
          presentationMode.wrappedValue.dismiss()
        }
        TextField(
          "Enter text", text: $textElement.text, onCommit: onCommit)
    }
}

struct TextPicker_Previews: PreviewProvider {
    static var previews: some View {
        TextPicker(textElement: .constant(TextElement()))
    }
}
