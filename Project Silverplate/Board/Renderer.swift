import MetalKit

final class Renderer: NSObject, MTKViewDelegate {
	let parent: BoardModelView

	let device: any MTLDevice
	let commandQueue: any MTLCommandQueue
	let pipeline: any MTLRenderPipelineState

	init(_ parent: BoardModelView) {
		self.parent = parent

		guard let metalDevice = MTLCreateSystemDefaultDevice() else {
			fatalError("Could not crate metal device!")
		}

		guard let commandQueue = metalDevice.makeCommandQueue() else {
			fatalError("Could not crate metal command queue!")
		}

		let pipeline = pipelineBuilder(metalDevice)

		self.device = metalDevice
		self.commandQueue = commandQueue
		self.pipeline = pipeline
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

		let renderEncoder = commandBuffer.makeRenderCommandEncoder(descriptor: renderPassDescriptor)!

		renderEncoder.setRenderPipelineState(self.pipeline)
		renderEncoder.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3)

		renderEncoder.endEncoding()

		commandBuffer.present(drawable)
		commandBuffer.commit()
	}
}


func pipelineBuilder(_ device: some MTLDevice) -> some MTLRenderPipelineState {
	guard let library = device.makeDefaultLibrary() else {
		fatalError("Could not create metal library!")
	}

	let pipelineDescriptor = MTLRenderPipelineDescriptor()
	pipelineDescriptor.vertexFunction = library.makeFunction(name: "vertex_main")
	pipelineDescriptor.fragmentFunction = library.makeFunction(name: "fragment_main")
	pipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm

	guard let pipeline = try? device.makeRenderPipelineState(descriptor: pipelineDescriptor) else {
		fatalError()
	}

	return pipeline
}
