import SwiftUI

struct LightingView: View {
//	@State private var brightness = 50.0
	@State private var speed = 50.0
	@State private var selectedColor = Color.black

	@Binding private var brightness: Double

	init(_ brightness: Binding<Double>) {
		self._brightness = brightness
	}

	var body: some View {
		VStack(spacing: 15) {
			Form {
				Section {
					
				}
				
				Section {
					
				}
			}
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(.background.secondary)
			.clipShape(.rect(cornerRadius: 10))
			
			HStack(spacing: 50) {
				VStack(alignment: .center) {
					HStack {
						Text("Brightness")
							.font(.caption)
						Spacer()
					}
					
					Slider(value: $brightness, in: 0...100, minimumValueLabel: Text("0"), maximumValueLabel: Text("100")) {}
					
					Text(String(format: "%.1f", brightness))
				}
				
				VStack(alignment: .center) {
					HStack {
						Text("Speed")
							.font(.caption)
						Spacer()
					}
					
					Slider(value: $speed, in: 0...100, minimumValueLabel: Text("0"), maximumValueLabel: Text("100")) {}
					
					Text(String(format: "%.1f", speed))
				}
			}
			
			HStack {
				ColorPicker("Color", selection: $selectedColor)
					.labelsHidden()

				Spacer()
				
				Button("Save") {
					
				}
			}
		}
	}
}
