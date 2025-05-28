import Metal
import MetalKit
import SwiftUI

struct ContentView: View {
	@State private var deviceModel = DeviceInfoModel()

	@State private var isShowingAddSheet = false

	@State private var selectedDevice: ConnectedDevice.ID?
	@State private var selectedPage: Page = .keymap

	@State private var keyTypeFilter: KeyType?
	@State private var selectedLayer = 0

	@State private var hidConnector = HIDConnector()

	@State private var sidebarOption: SidebarOption = .pages

	@State private var columnVisibility = NavigationSplitViewVisibility.all

	var body: some View {
		NavigationSplitView(columnVisibility: .constant(.all)) {
			SidebarView(hidConnector.connectedDevices, $sidebarOption, $selectedDevice, $selectedPage)
				.navigationSplitViewColumnWidth(170)
		} detail: {
			
			GeometryReader { proxy in
				VStack(spacing: 0) {
					BoardModelView($deviceModel.brightness)
						.frame(minHeight: proxy.size.height / 2)
						.frame(maxWidth: .infinity)

					Divider().frame(minWidth: 50)

					VStack {
						switch selectedPage {
							case .keymap:
								KeymapView()
							case .lighting:
								LightingView($deviceModel.brightness)
							case .firmware:
								FirmwareView()
							case .keyTest:
								KeyTestView()
						}
					}
					.padding()
				}
			}
			.ignoresSafeArea(.all)
			.navigationSplitViewColumnWidth(min: 500, ideal: 500)
//			.toolbar(.hidden)
//			.toolbar(removing: .title)
//			.toolbarBackground(.clear, for: .windowToolbar)
//			.windowToolbarFullScreenVisibility(.visible)
//			.toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
		}
		.frame(minHeight: 500)
	}
}


@Observable
final class DeviceInfoModel {
	var brightness: Double

	init() {
		self.brightness = 0
	}
}


enum Page: Int {
	case keymap
	case lighting
	case firmware
	case keyTest
}

//#Preview {
//	ContentView()
//}
