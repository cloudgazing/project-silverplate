import SwiftUI

struct KeymapView: View {
	@State private var keyTypeFilter: KeyType?
	@State private var selectedLayer = 0

	var body: some View {
		VStack {
			HStack {
				VStack(alignment: .leading) {
					Text("Filter")
						.font(.caption)
					Picker("Filter", selection: Binding(
						get: { keyTypeFilter },
						set: {
							if keyTypeFilter == $0 {
								keyTypeFilter = nil
							} else {
								keyTypeFilter = $0
							}
						}
					)) {
						Text("Basic").tag(KeyType.basic)
						Text("Media").tag(KeyType.media)
						Text("System").tag(KeyType.system)
						Text("Layer").tag(KeyType.layer)
						Text("Macro")
							.tag(KeyType.macro)
							.disabled(true)
					}
					.pickerStyle(.segmented)
					.labelsHidden()
					.frame(maxWidth: 400)
				}

				Spacer().frame(minWidth: 20)

				VStack(alignment: .leading) {
					Text("Layer")
						.font(.caption)
					Picker("Layer", selection: $selectedLayer) {
						Text("0").tag(0)
						Text("1").tag(1)
						Text("2").tag(2)
						Text("3").tag(3)
					}
					.pickerStyle(.segmented)
					.labelsHidden()
					.frame(maxWidth: 200)
				}
			}

			ScrollView {
				VStack {

				}
			}
			.frame(maxWidth: .infinity)
			.background(.background.secondary)
			.clipShape(.rect(cornerRadius: 10))
		}
	}
}
