import Metal
import SwiftUI

final class UsedShapes {
	let background: Mesh
	let idleModel: Mesh
	let kbModel: Mesh

	init(_ device: borrowing any MTLDevice) {
		let backgroundCoords: QuadCoordinates = (
			[-1,  1, 0, 1],
			[ 1,  1, 0, 1],
			[ 1, -1, 0, 1],
			[-1, -1, 0, 1],
		)
		let backgroundColors: QuadColors = (
			[0.9294117647058824, 0.44313725490196076, 0.6784313725490196],
			[0.7686274509803922, 0.45098039215686275, 0.7686274509803922],
			[0.6078431372549019, 0.45882352941176470, 0.8549019607843137],
			[0.4470588235294118, 0.46666666666666670, 0.9450980392156862],
		)

		let idleCoords: QuadCoordinates = (
			[-0.75,  0.75, 0, 1],
			[ 0.75,  0.75, 0, 1],
			[ 0.75, -0.75, 0, 1],
			[-0.75, -0.75, 0, 1],
		)
		let idleColors: QuadColors = (
			[0, 0, 0],
			[0, 0, 0],
			[0, 0, 0],
			[0, 0, 0],
		)

		let kbCoords: QuadCoordinates = (
			[-0.75,  0.75, 0, 1],
			[ 0.75,  0.75, 0, 1],
			[ 0.75, -0.75, 0, 1],
			[-0.75, -0.75, 0, 1],
		)
		let kbColors: QuadColors = (
			[0.12549019607843137, 0.12549019607843137, 0.12549019607843137],
			[0.12549019607843137, 0.12549019607843137, 0.12549019607843137],
			[0.12549019607843137, 0.12549019607843137, 0.12549019607843137],
			[0.12549019607843137, 0.12549019607843137, 0.12549019607843137],
		)

		self.background = makeQuad(device, backgroundCoords, backgroundColors)
		self.idleModel = makeQuad(device, idleCoords, idleColors)
		self.kbModel = makeQuad(device, kbCoords, kbColors)
	}
}

typealias QuadCoordinates = (vector_float4, vector_float4, vector_float4, vector_float4)
typealias QuadColors = (vector_float3, vector_float3, vector_float3, vector_float3)

func makeQuad(_ device: some MTLDevice, _ coordinates: QuadCoordinates, _ colors: QuadColors) -> Mesh {
	let vertices = [
		Vertex(position: coordinates.0, color: colors.0),
		Vertex(position: coordinates.1, color: colors.1),
		Vertex(position: coordinates.2, color: colors.2),
		Vertex(position: coordinates.3, color: colors.3),
	]

	let indeces: [UInt16] = [0, 1, 2, 2, 3, 0]

	let vertexBuffer = device.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout<Vertex>.stride)!
	let indexBuffer = device.makeBuffer(bytes: indeces, length: indeces.count * MemoryLayout<UInt16>.stride)!

	return Mesh(vertexBuffer: vertexBuffer, indexBuffer: indexBuffer, count: indeces.count)
}

struct Mesh {
	let vertexBuffer: any MTLBuffer
	let indexBuffer: any MTLBuffer
	let count: Int
}
