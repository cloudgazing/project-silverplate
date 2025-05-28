import SwiftUI

struct SettingsView: View {
	@Environment(\.openURL) private var openURL
	@Environment(\.dismissWindow) private var dismissWindow

	@AppStorage("startPage") private var startPage: Page = .keymap
	@AppStorage("isCanvasEnabled") private var isCanvasEnabled = true

	var body: some View {
		Form {
			Section {
				Picker("Default start page:", selection: $startPage) {
					Text("Keymap").tag(Page.keymap)
					Text("Lighting").tag(Page.lighting)
					Text("Firmware").tag(Page.firmware)
					Text("Key Test").tag(Page.keyTest)
				}
			}

			Section {
				Toggle("Show keyboard canvas", isOn: $isCanvasEnabled)
			}

			Section {
				HStack {
					Button("Report an issue") {
						guard let url = URL(string: "https://github.com/cloudgazing/project-silverplate/issues") else { return }

						openURL(url)
					}

					Spacer()

					Button("Reset the app") {
						guard let url = URL(string: "https://github.com/cloudgazing/project-silverplate/issues") else { return }

						openURL(url)
					}
					.buttonStyle(.borderedProminent)
					.tint(.red)
				}
			}
		}
		.formStyle(.grouped)
		.fixedSize()
		.toolbar(removing: .title)
		.toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
		.focusable()
		.focusEffectDisabled()
		.onExitCommand {
			dismissWindow()
		}
	}
}
