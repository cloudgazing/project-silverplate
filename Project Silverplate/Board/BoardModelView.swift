import MetalKit
import SwiftUI

struct BoardModelView: NSViewRepresentable {

	@Binding private var brightness: Double

	init(_ brightness: Binding<Double>) {
		self._brightness = brightness
	}

	// MARK: -- Metal Renderer View --

	internal final class Coordinator: NSObject, MTKViewDelegate {
		var parent: BoardModelView

		let device: any MTLDevice
		let commandQueue: any MTLCommandQueue
		let pipeline: any MTLRenderPipelineState

		let usedShapes: UsedShapes

		init(_ parent: BoardModelView) {
			self.parent = parent

			let metalDevice = MTLCreateSystemDefaultDevice()!

			let commandQueue = metalDevice.makeCommandQueue()!

			let pipeline = pipelineBuilder(metalDevice)

			let shapes = UsedShapes(metalDevice)

			self.device = metalDevice
			self.commandQueue = commandQueue
			self.pipeline = pipeline
			self.usedShapes = shapes
		}

		func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {

		}

		func draw(in view: MTKView) {
			guard let drawable = view.currentDrawable else {
				return
			}

			let commandBuffer = self.commandQueue.makeCommandBuffer()!

			let renderPassDescriptor = view.currentRenderPassDescriptor!
			renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0, 0, 0, 0)
			renderPassDescriptor.colorAttachments[0].loadAction = .clear
			renderPassDescriptor.colorAttachments[0].storeAction = .store

//			let depthDesc = MTLDepthStencilDescriptor()
//			depthDesc.depthCompareFunction = .less
//			depthDesc.isDepthWriteEnabled = true

//			let depthState = device.makeDepthStencilState(descriptor: depthDesc)!

			let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)!


			renderEncoder.setRenderPipelineState(self.pipeline)
	//		renderEncoder.setDepthStencilState(depthState)

			let bg = self.usedShapes.background
			renderEncoder.setVertexBuffer(bg.vertexBuffer, offset: 0, index: 0)
			renderEncoder.drawIndexedPrimitives(
				type: .triangle,
				indexCount: bg.count,
				indexType: .uint16,
				indexBuffer: bg.indexBuffer,
				indexBufferOffset: 0
			)

			let kbModel = self.usedShapes.kbModel
			renderEncoder.setVertexBuffer(kbModel.vertexBuffer, offset: 0, index: 0)
			renderEncoder.drawIndexedPrimitives(
				type: .triangle,
				indexCount: kbModel.count,
				indexType: .uint16,
				indexBuffer: kbModel.indexBuffer,
				indexBufferOffset: 0
			)

			renderEncoder.endEncoding()

			commandBuffer.present(drawable)
			commandBuffer.commit()
		}
	}

	// MARK: -- SwiftUI Wrapper --

	func makeCoordinator() -> Coordinator {
		print("coordinator created")

		return Coordinator(self)
	}

	func makeNSView(context: Context) -> MTKView {
		let mtkView = MTKView()

		mtkView.preferredFramesPerSecond = 60
		mtkView.enableSetNeedsDisplay = true

		if let metalDevice = MTLCreateSystemDefaultDevice() {
			mtkView.device = metalDevice
		}

		mtkView.framebufferOnly = false
		mtkView.drawableSize = mtkView.frame.size
		mtkView.layer?.isOpaque = false
//		mtkView.depthStencilPixelFormat = .depth32Float

		mtkView.delegate = context.coordinator

		return mtkView
	}

	func updateNSView(_ view: MTKView, context: Context) {
		print("Brightness value: \(brightness)")

		view.draw()
	}
}

func pipelineBuilder(_ device: some MTLDevice) -> some MTLRenderPipelineState {
	let library = device.makeDefaultLibrary()!

	let vertexFunction = library.makeFunction(name: "vertex_shader")!
	let fragmentFunction = library.makeFunction(name: "fragment_shader")!

	let pipelineDescriptor = MTLRenderPipelineDescriptor()
	pipelineDescriptor.vertexFunction = vertexFunction
	pipelineDescriptor.fragmentFunction = fragmentFunction
	pipelineDescriptor.colorAttachments[0].isBlendingEnabled = true
	pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm

	let pipeline = try! device.makeRenderPipelineState(descriptor: pipelineDescriptor)

	return pipeline
}
