import Metal
import SwiftUI

struct ContentView: View {
	@State private var selected: String = "Nothing selected"

	var body: some View {
		VStack {
			BoardModelView()
				.frame(minWidth: 50, minHeight: 50)

			Divider()
				.padding(.vertical)

			HStack {
				VStack {
					Button {
						selected = "device configuration"
					} label: {
						Image(systemName: "text.book.closed")
					}

					Button {
						selected = "device settings"
					} label: {
						Image(systemName: "gearshape")
					}
				}
				.buttonStyle(.borderless)
				.font(.system(size: 15))

				VStack {
					Text(selected)
						.font(.headline)
				}
				.frame(maxWidth: .infinity)

			}

		}
		.padding()
		.toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
		.focusable(false)
	}
}
