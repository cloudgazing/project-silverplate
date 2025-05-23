import SwiftUI

struct KeyView: View {
	private let name: String

	init(_ name: String) {
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
