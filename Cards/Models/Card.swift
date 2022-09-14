import SwiftUI

struct Card: Identifiable {
  var id = UUID()
  var backgroundColor: Color = .yellow
  var elements: [CardElement] = []
  var image: UIImage?
  var shareImage: UIImage?

  func save() {
    do {
      let encoder = JSONEncoder()
      encoder.outputFormatting = .prettyPrinted
      let data = try encoder.encode(self)
      let filename = "\(id).rwcard"
      if let url = FileManager.documentURL?
        .appendingPathComponent(filename) {
        try data.write(to: url)
      }
    } catch {
      print(error.localizedDescription)
    }
  }

  mutating func remove(_ element: CardElement) {
    if let element = element as? ImageElement {
      UIImage.remove(name: element.imageFilename)
    }
    if let index = element.index(in: elements) {
      elements.remove(at: index)
    }
    save()
  }

  mutating func addElement(_ textElement: TextElement) {
    elements.append(textElement)
    save()
  }

  mutating func addElement(
    uiImage: UIImage,
    transform: Transform = Transform()
  ) {
    let imageFilename = uiImage.save()
    let image = Image(uiImage: uiImage)
    let element = ImageElement(
      transform: transform,
      image: image,
      imageFilename: imageFilename)
    elements.append(element)
    save()
  }

  mutating func update(_ element: CardElement?, frame: AnyShape) {
    if let element = element as? ImageElement,
      let index = element.index(in: elements) {
        var newElement = element
        newElement.frame = frame
        elements[index] = newElement
    }
    save()
  }
}

extension Card: Codable {
  enum CodingKeys: CodingKey {
    case id, backgroundColor, imageElements, textElements
  }

  init(from decoder: Decoder) throws {
    let container =
      try decoder.container(keyedBy: CodingKeys.self)
    let id = try container.decode(String.self, forKey: .id)
    self.id = UUID(uuidString: id) ?? UUID()
    elements += try container.decode(
      [ImageElement].self, forKey: .imageElements)

    // Challenge 2 - load the text elements
    elements += try container.decode([TextElement].self, forKey: .textElements)

    // Challenge 1 - load the background color
    let components = try container.decode([CGFloat].self, forKey: .backgroundColor)
    backgroundColor = Color.color(components: components)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(id.uuidString, forKey: .id)
    let imageElements: [ImageElement] =
      elements.compactMap { $0 as? ImageElement }
    try container.encode(imageElements, forKey: .imageElements)

    // Challenge 2 - save the text elements
    let textElements: [TextElement] =
      elements.compactMap { $0 as? TextElement }
    try container.encode(textElements, forKey: .textElements)

    // Challenge 1 - save the background color
    let components = backgroundColor.colorComponents()
    try container.encode(components, forKey: .backgroundColor)
  }
}
