import SwiftUI

struct AboutView: View {
	@Environment(\.openURL) private var openURL
	@Environment(\.dismissWindow) private var dismissWindow

	var body: some View {
		HStack(spacing: 0) {
			Image(nsImage: NSApp.applicationIconImage)

			VStack(alignment: .leading, spacing: 5) {
				Text("Project Silverplate")
					.font(.title)

				HStack(spacing: 0) {
					Text("Version: ")
					Text("0.0.1")
						.textSelection(.enabled)
				}
				.font(.caption)
				.foregroundStyle(.secondary)

				Spacer()

				HStack {
					Text("© 2025 cloudgazing.")
						.font(.caption)
						.foregroundStyle(.secondary)

					Spacer()

					Button("License") {
						guard let url = URL(string: "https://github.com/cloudgazing/project-silverplate") else { return }

						openURL(url)
					}
				}
			}
			.frame(maxWidth: .infinity)
			.padding()
		}
		.padding()
		.frame(width: 400)
		.fixedSize()
		.gesture(WindowDragGesture())
		.containerBackground(.thickMaterial, for: .window)
		.windowMinimizeBehavior(.disabled)
		.allowsWindowActivationEvents(true)
		.focusable()
		.focusEffectDisabled()
		.toolbar(removing: .title)
		.toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
		.onAppear {
			guard let window = NSApp.windows.first(where: { $0.identifier?.rawValue == "about" }) else { return }

			window.center()
		}
		.onExitCommand {
			dismissWindow()
		}
	}
}
