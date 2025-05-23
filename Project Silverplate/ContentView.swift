import Metal
import SwiftUI

struct ContentView: View {
	@State private var isShowingAddSheet = false

	@State private var hidConnector = HIDConnector()

	@State private var isConnected = true

	@State private var keyTypeFilter: KeyTypeFilter?
	@State private var selectedLayer = 0

	var body: some View {
		NavigationSplitView {
			List {
				Section("Devices") {
					Label("Add device", systemImage: "plus")
						.onTapGesture {
							isShowingAddSheet.toggle()
						}
				}

				Divider()

				Label("Keymap", systemImage: "keyboard")
				Label("Lighting", systemImage: "lightbulb.led")
				Label("Firmware", systemImage: "cpu")
				Label("Key test", systemImage: "testtube.2")
			}
			.navigationSplitViewColumnWidth(min: 150, ideal: 150, max: 150)
		} detail: {
			GeometryReader { proxy in
				VStack(spacing: 0) {
					VStack(alignment: .center) {
						if isConnected {
							BoardModelView()
								.aspectRatio(1, contentMode: .fit)
								.contentTransition(.identity)
						} else {
							Image(systemName: "keyboard.fill")
								.font(.system(size: 80))
								.symbolEffect(.pulse, isActive: !isConnected)
								.contentTransition(.symbolEffect(.replace))
						}
					}
					.frame(height: proxy.size.height / 2)
					.frame(maxWidth: .infinity)
					.ignoresSafeArea(edges: [.top])

					Divider().frame(minWidth: 50)

					VStack {
						HStack {
							VStack(alignment: .leading) {
								Text("Filter")
									.font(.caption)
								Picker("Filter", selection: Binding(
									get: { keyTypeFilter },
									set: {
										if keyTypeFilter == $0 {
											keyTypeFilter = nil
										} else {
											keyTypeFilter = $0
										}
									}
								)) {
									Text("Basic").tag(KeyTypeFilter.basic)
									Text("Media").tag(KeyTypeFilter.media)
									Text("System").tag(KeyTypeFilter.system)
									Text("Layer").tag(KeyTypeFilter.layer)
									Text("Macro")
										.tag(KeyTypeFilter.macro)
										.disabled(true)
								}
								.pickerStyle(.segmented)
								.labelsHidden()
							}

							Spacer().frame(minWidth: 20)

							VStack(alignment: .leading) {
								Text("Layer")
									.font(.caption)
								Picker("Layer", selection: $selectedLayer) {
									Text("0").tag(0)
									Text("1").tag(1)
									Text("2").tag(2)
									Text("3").tag(3)
								}
								.pickerStyle(.segmented)
								.labelsHidden()
							}
						}

						ScrollView {
							VStack {

							}
						}
						.frame(maxWidth: .infinity)
						.background(.gray.opacity(0.1))
						.clipShape(.rect(cornerRadius: 5))
					}
					.padding()
				}
				.sheet(isPresented: $isShowingAddSheet) {
					VStack {
						VStack(spacing: 10) {
							Text("Looking for devices")
								.font(.title)
							Image(systemName: "ellipsis")
								.symbolEffect(.variableColor)
								.font(.system(size: 30))
						}

						Spacer()

						HStack {
							Button("Close") {
								isShowingAddSheet = false
							}

							Spacer()

							Button("Add Config File") {
								// Open the sheet which lets you add a file, then parse it
							}
							.buttonStyle(.borderedProminent)
						}
						.frame(maxWidth: .infinity)
					}
					.padding()
					.frame(width: proxy.size.width * 0.75, height: proxy.size.height * 0.75)
				}
			}
			.navigationSplitViewColumnWidth(min: 500, ideal: 500)
		}
		.toolbar(removing: .title)
		.toolbarBackgroundVisibility(.hidden, for: .windowToolbar)
	}
}

private enum KeyTypeFilter {
	case basic
	case media
	case system
	case layer
	case macro
}

private enum ViewWindow {
	case addDevice
	case keymap
	case lighting
	case firmware
	case keyTest
}
