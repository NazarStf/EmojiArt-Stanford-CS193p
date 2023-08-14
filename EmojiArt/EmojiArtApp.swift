//
//  EmojiArtApp.swift
//  EmojiArt
//
//  Created by NazarStf on 14.08.2023.
//

import SwiftUI

@main
struct EmojiArtApp: App {
	let document = EmojiArtDocument()
	var body: some Scene {
		WindowGroup {
			EmojiArtDocumentView(document: document)
		}
	}
}
