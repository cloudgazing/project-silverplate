import MetalKit
import SwiftUI

struct BoardModelView: NSViewRepresentable {
	func makeCoordinator() -> Renderer {
		Renderer(self)
	}

	func makeNSView(context: Context) -> MTKView {
		let mtkView = MTKView()

		mtkView.delegate = context.coordinator
		mtkView.preferredFramesPerSecond = 60
		mtkView.enableSetNeedsDisplay = true

		if let metalDevice = MTLCreateSystemDefaultDevice() {
			mtkView.device = metalDevice
		}

		mtkView.framebufferOnly = false
		mtkView.drawableSize = mtkView.frame.size
		mtkView.layer?.isOpaque = false

		return mtkView
	}

	func updateNSView(_ nsView: MTKView, context: Context) {

	}
}
