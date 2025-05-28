import SwiftUI

struct AppCommands: Commands {
	@Environment(\.openURL) private var openURL
	@Environment(\.openWindow) private var openWindow

	var body: some Commands {
		CommandGroup(replacing: .appInfo) {
			Button("About App") {
				openWindow(id: "about")
			}
		}
		CommandGroup(after: .help) {
			Button("GitHub repository") {
				guard let url = URL(string: "https://github.com/cloudgazing/project-silverplate") else { return }

				openURL(url)
			}
		}
	}
}
