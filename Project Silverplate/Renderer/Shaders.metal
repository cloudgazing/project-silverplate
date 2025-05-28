#include <metal_stdlib>

#include "ShaderTypes.h"

using namespace metal;

struct VertexOut {
	float4 position [[position]];
	float3 color;
};

vertex VertexOut vertex_shader(
  unsigned short vid [[vertex_id]],
  const device Vertex *vertices [[buffer(0)]]
) {
	VertexOut out;

	Vertex v = vertices[vid];

	out.position = v.position;
	out.color = float3(v.color);

	return out;
}

fragment float4 fragment_shader(VertexOut in [[stage_in]]) {
	return float4(in.color, 1.0);
}
