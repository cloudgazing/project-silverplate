import SwiftUI

@main
struct SilverplateApp: App {
	var body: some Scene {
		WindowGroup {
			ContentView()
		}
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
