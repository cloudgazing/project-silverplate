import SwiftUI

@main
struct SilverplateApp: App {

	init() {
		NSWindow.allowsAutomaticWindowTabbing = false
	}

	var body: some Scene {
		WindowGroup {
			ContentView()
		}
		.windowToolbarStyle(.unified(showsTitle: false))
		.windowStyle(.hiddenTitleBar)
		.windowToolbarLabelStyle(fixed: .iconOnly)
		.commandsRemoved()
		.commands { AppCommands() }

		Window("About App", id: "about") {
			AboutView()
		}
		.windowBackgroundDragBehavior(.enabled)
		.windowResizability(.contentSize)
		.restorationBehavior(.disabled)
		.defaultPosition(UnitPoint(x: 0.5, y: 0.25))

		Settings {
			SettingsView()
		}
		.windowResizability(.automatic)
	}
}

