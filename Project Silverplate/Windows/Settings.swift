import SwiftUI

struct SettingsView: View {
	@Environment(\.dismissWindow) private var dismissWindow

	var body: some View {
		VStack {
			Text("Settings Window")
		}
		.padding()
		.toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
		.focusable()
		.focusEffectDisabled()
		.scaledToFit()
		.onExitCommand {
			dismissWindow()
		}
	}
}
