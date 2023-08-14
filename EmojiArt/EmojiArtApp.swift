//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by NazarStf on 14.08.2023.
//

import SwiftUI

@main
struct EmojiArtApp: App {
	@StateObject var document = EmojiArtDocument()
	@StateObject var paletteStore = PaletteStore(named: "Default")
	
	var body: some Scene {
		WindowGroup {
			EmojiArtDocumentView(document: document)
				.environmentObject(paletteStore)
		}
	}
}
