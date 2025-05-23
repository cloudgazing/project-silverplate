import IOKit.hid
import SwiftUI

let deviceMatch: [String: UInt16] = [
	kIOHIDVendorIDKey: 0x16C0,
	kIOHIDProductIDKey: 0x27DD,
]

@Observable
final class HIDConnector {
	private let manager: IOHIDManager

	init() {
		let manager = IOHIDManagerCreate(kCFAllocatorDefault, IOOptionBits(kIOHIDOptionsTypeNone))

		IOHIDManagerSetDeviceMatching(manager, deviceMatch as CFDictionary)

		IOHIDManagerScheduleWithRunLoop(manager, CFRunLoopGetCurrent(), CFRunLoopMode.defaultMode.rawValue)
		IOHIDManagerOpen(manager, 0)

		let matchingCallback: IOHIDDeviceCallback = { selfPtr, result, sender, device in
			guard let selfPtr = selfPtr else {
				fatalError("Self ptr is null in matching callback")
			}

			let hidConnector = Unmanaged<HIDConnector>.fromOpaque(selfPtr).takeUnretainedValue()

			hidConnector.onMatchingDevice()
		}

		let removalCallback: IOHIDDeviceCallback = { selfPtr, result, sender, device in
			guard let selfPtr = selfPtr else {
				fatalError("Self ptr is null in removal callback")
			}

			let hidConnector = Unmanaged<HIDConnector>.fromOpaque(selfPtr).takeUnretainedValue()

			hidConnector.onRemovedDevice()
		}

		self.manager = manager

		let selfPtr = Unmanaged.passRetained(self).toOpaque()

		IOHIDManagerRegisterDeviceMatchingCallback(manager, matchingCallback, selfPtr)
		IOHIDManagerRegisterDeviceRemovalCallback(manager, removalCallback, selfPtr)
	}

	private func onMatchingDevice() {

	}

	private func onRemovedDevice() {

	}
}
