//
//  EmojiArtModel.swift
//  EmojiArt
//
//  Created by NazarStf on 14.08.2023.
//

import Foundation

struct EmojiArtModel {
	var background = Background.blank
	var emojis = [Emoji]()
	
	struct Emoji: Identifiable {
		let text: String
		var x: Int
		var y: Int
		var size: Int
		var id: Int
	}
	
	init() { }
	
	private var uniqueEmojiId = 0
	
	mutating func addEmoji(_ text: String, at location: (x: Int, y: Int), size: Int) {
		uniqueEmojiId += 1
		emojis.append(Emoji(text: text, x: location.x, y: location.y, size: size, id: uniqueEmojiId))
	}
}

extension EmojiArtModel {
	enum Background: Equatable {
		case blank
		case url(URL)
		case imageData(Data)
		
		var url: URL? {
			switch self {
			case .url(let url): return url
			default: return nil
			}
		}
		
		var imageData: Data? {
			switch self {
			case .imageData(let data): return data
			default: return nil
			}
		}
	}
}
