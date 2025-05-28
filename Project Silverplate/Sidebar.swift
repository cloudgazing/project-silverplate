import SwiftUI

struct SidebarView: View {
	private var connectedDevices: [ConnectedDevice]
	//	private var scannedDevices: [ScannedDevice]

	@Binding private var selectedDevice: ConnectedDevice.ID?
	@Binding private var sidebarOption: SidebarOption
	@Binding private var selectedPage: Page

	@State private var isTitlebarHidden = false

	init(
		_ connectedDevices: [ConnectedDevice],
		_ sidebarOption: Binding<SidebarOption>,
		_ selectedDevice: Binding<ConnectedDevice.ID?>,
		_ selectedPage: Binding<Page>
	) {
		self.connectedDevices = connectedDevices
		self._sidebarOption = sidebarOption
		self._selectedDevice = selectedDevice
		self._selectedPage = selectedPage
	}

	var body: some View {
		Group {
			switch sidebarOption {
				case .pages:
					List(selection: $selectedPage) {
						Section("Configuration") {
							Label("Keymap", systemImage: "keyboard")
								.tag(Page.keymap)
							Label("Lighting", systemImage: "lightbulb.led")
								.tag(Page.lighting)
							Label("Firmware", systemImage: "cpu")
								.tag(Page.firmware)
							Label("Key test", systemImage: "testtube.2")
								.tag(Page.keyTest)
						}
						.collapsible(false)
					}
				case .devices:
					List(selection: $selectedDevice) {
						Section("Connected") {
							ForEach(connectedDevices, id: \.self.id) { device in
								ConnectedDeviceView(device.name, device.deviceType)
									.tag(device.id)
							}
						}
						.collapsible(false)

						Section("Scanned") {

						}
					}
			}
		}
		.toolbar(removing: .sidebarToggle)
		.toolbar {
			Picker(selection: $sidebarOption) {
				Image(systemName: "text.page")
					.tag(SidebarOption.pages)

				Image(systemName: "cable.connector")
					.tag(SidebarOption.devices)
			} label: {}
				.pickerStyle(.segmented)
				.labelsHidden()
				.controlSize(.regular)
				.onTapGesture {
					print("hey")
				}
		}
	}
}

enum SidebarOption {
	case pages
	case devices
}
