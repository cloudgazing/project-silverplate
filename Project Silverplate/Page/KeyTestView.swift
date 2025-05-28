import SwiftUI

struct KeyTestView: View {
	@State private var text: String = ""

	@FocusState private var keyTestFocus: Bool

	@State private var lastPressedKey: KeyEquivalent?

	var body: some View {
		VStack(spacing: 0) {
			HStack {
				HStack {
					Text("Pressed key:")
						.font(.title)
						.fontWeight(.bold)

					VStack {
						if let lastPressedKey {
							Text("\"\(lastPressedKey.character)\"")
								.font(.title2)
								.fontWeight(.bold)
						}
					}
					.frame(minWidth: 35)
				}
				.padding(10)
				.focusable()
				.focusEffectDisabled()
				.focused($keyTestFocus)
				.overlay(
					RoundedRectangle(cornerRadius: 10)
						.stroke(keyTestFocus ? Color.accentColor : .clear, lineWidth: 1)
				)
				.onKeyPress { press in
					lastPressedKey = press.key

					return .handled
				}

				Spacer()
			}

			Spacer().frame(maxHeight: 5)

			TextEditor(text: $text)
				.padding()
				.scrollContentBackground(.hidden)
				.background(.background.secondary)
				.clipShape(.rect(cornerRadius: 10))
		}
	}
}
