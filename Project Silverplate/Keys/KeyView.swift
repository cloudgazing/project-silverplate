import SwiftUI

struct KeyView: View {
	private let keyType: KeyType
	private let name: String

	init(_ name: String, _ keyType: KeyType) {
		self.keyType = keyType
		self.name = name
	}

	var body: some View {
		Text(name)
			.frame(minWidth: 40, minHeight: 40)
			.aspectRatio(1, contentMode: .fit)
			.background(Color.gray)
			.cornerRadius(10)
	}
}

enum KeyType {
	case basic
	case media
	case system
	case layer
	case macro
}
