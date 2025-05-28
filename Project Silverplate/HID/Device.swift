import IOKit.hid
import SwiftUI

final class ScannedDevice {
	let device: IOHIDDevice

	init(_ device: IOHIDDevice) {
		self.device = device
	}
}

final class ConnectedDevice: Identifiable {
	//	let device: IOHIDDevice
	let deviceType: DeviceType

	var name: String

	//	init(_ device: IOHIDDevice, _ name: String) {
	//		self.device = device
	//		self.name = name
	//	}
	init( _ name: String, _ deviceType: DeviceType) {
		//		self.device = device
		self.deviceType = deviceType
		self.name = name

	}
}

struct ScannedDeviceView: View {
	private let name: String

	@State private var isExpanded: Bool = false

	init(_ name: String) {
		self.name = name
	}

	var body: some View {
		VStack(spacing: 0) {
			Text(name)
				.font(.callout)
				.padding(.vertical)

			if isExpanded {
				Divider()

				HStack {
					Button("Connect") {

					}

					Spacer()
				}
				.padding(.vertical)
			}
		}
		.padding(.horizontal)
		.frame(maxWidth: .infinity)
		.background(.background.secondary)
		.clipShape(.rect(cornerRadius: 10))
		.onTapGesture {
			isExpanded.toggle()
		}
	}
}

struct ConnectedDeviceView: View {
	let deviceType: DeviceType
	let name: String

	@State private var isHovered = false
	@State private var disconnectIsHovered = false

	init(_ name: String, _ deviceType: DeviceType) {
		self.deviceType = deviceType
		self.name = name
	}

	var body: some View {
		HStack {
			Label(name, systemImage: {
				switch deviceType {
					case .keyboard:
						"keyboard.fill"
					case .controller:
						"gamecontroller.fill"
				}
			}())

			Spacer()

			Image(systemName: "powerplug.portrait.fill")
				.foregroundStyle(disconnectIsHovered ? .primary : .secondary)
				.symbolEffect(.appear, isActive: !isHovered)
				.symbolEffect(.disappear, isActive: !isHovered)
				.onHover { isHovered in
					withAnimation(.linear(duration: 0.1)) {
						disconnectIsHovered = isHovered
					}
				}

		}
		.onHover {
			isHovered = $0
		}
	}
}

enum DeviceType {
	case keyboard
	case controller
}
