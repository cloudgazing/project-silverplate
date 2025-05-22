#include <metal_stdlib>
using namespace metal;

struct VertexPayload {
	float4 position [[position]];
	half3 color;
};

constant float4 positions[] {
	float4(-0.75, -0.75, 0.0, 1.0),
	float4(0.75, -0.75, 0.0, 1.0),
	float4(0.0, 0.75, 0.0, 1.0),
};


constant half3 colors[] {
	half3(1.0, 0.0, 0.0),
	half3(0.0, 1.0, 0.0),
	half3(0.0, 0.0, 1.0),
};

VertexPayload vertex vertex_main(uint vertex_id [[vertex_id]]) {
	VertexPayload payload;
	
	payload.position = positions[vertex_id];
	payload.color = colors[vertex_id];
	
	return payload;
}

half4 fragment fragment_main(VertexPayload frag [[stage_in]]) {
	return half4(frag.color, 1.0);
}
