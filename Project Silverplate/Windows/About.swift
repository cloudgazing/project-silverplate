import SwiftUI

struct AboutView: View {
	@Environment(\.dismissWindow) private var dismissWindow

	var body: some View {
		VStack {
			Text("About Window")
		}
		.padding()
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
