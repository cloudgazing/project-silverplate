import SwiftUI

struct FirmwareView: View {
	@State private var isCheckingUpdate = false
	@State private var isUpdateAvailable = false

	var body: some View {
		GeometryReader { proxy in
			HStack(spacing: 0) {
				Form {
					Section {
						HStack {
							Text("Model name:")
							Text("MoonQuartz")
						}
						HStack {
							Text("Current version:")
							Text("0.0.1")
						}
						HStack(alignment: .bottom) {
							Text("Latest version:")

							if isCheckingUpdate {
								Image(systemName: "ellipsis")
									.symbolEffect(.variableColor)
							} else {
								Text("0.0.1")
									.animation(.smooth)
									.fontWeight( isUpdateAvailable ? .bold : .regular)
							}
						}
						HStack {
							Text("Firmware date: ")
							Text("2025-01-01")
						}
					}

					Section {
						if isUpdateAvailable {
							Button("Install update") {

							}
							.buttonStyle(.borderedProminent)
						} else {
							Button("Check for update") {
								Task {
									withAnimation(.easeOut(duration: 0.1)) {
										isCheckingUpdate = true
									}

									try? await Task.sleep(for: .seconds(1))

									withAnimation(.easeOut(duration: 0.1)) {
										isCheckingUpdate = false
									}
								}
							}
							.disabled(isCheckingUpdate)
						}
					}
				}
				.formStyle(.grouped)
				.frame(width: proxy.size.width / 2)
				.frame(maxHeight: .infinity)

				Form {
					Section {
						Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.")
					}

					Section {
						HStack {
							Button("Export config file") {

							}

							Spacer()

							Button("Manual flash") {

							}
						}
					}
				}
				.formStyle(.grouped)
				.frame(width: proxy.size.width / 2)
				.frame(maxHeight: .infinity)
			}
		}
	}
}
