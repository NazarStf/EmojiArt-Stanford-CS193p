//
//  EmojiArtModel.swift
//  EmojiArt
//
//  Created by NazarStf on 14.08.2023.
//

import Foundation

struct EmojiArtModel: Codable {
	var background = Background.blank
	var emojis = [Emoji]()
	
	struct Emoji: Identifiable, Hashable, Codable {
		let text: String
		var x: Int // offset from the center
		var y: Int // offset from the center
		var size: Int
		let id: Int
		
		fileprivate init(text: String, x: Int, y: Int, size: Int, id: Int) {
			self.text = text
			self.x = x
			self.y = y
			self.size = size
			self.id = id
		}
	}
	
	func json() throws -> Data {
		return try JSONEncoder().encode(self)
	}
	
	init(json: Data) throws {
		self = try JSONDecoder().decode(EmojiArtModel.self, from: json)
	}
	
	init(url: URL) throws {
		let data = try Data(contentsOf: url)
		self = try EmojiArtModel(json: data)
	}
	
	init() { }
	
	private var uniqueEmojiId = 0
	
	mutating func addEmoji(_ text: String, at location: (x: Int, y: Int), size: Int) {
		uniqueEmojiId += 1
		emojis.append(Emoji(text: text, x: location.x, y: location.y, size: size, id: uniqueEmojiId))
	}
}

extension EmojiArtModel {
	enum Background: Equatable, Codable {
		case blank
		case url(URL)
		case imageData(Data)
		
		init(from decoder: Decoder) throws {
			let container = try decoder.container(keyedBy: CodingKeys.self)
			if let url = try? container.decode(URL.self, forKey: .url) {
				self = .url(url)
			} else if let imageData = try? container.decode(Data.self, forKey: .imageData) {
				self = .imageData(imageData)
			} else {
				self = .blank
			}
		}
		
		enum CodingKeys: String, CodingKey {
			case url = "theURL"
			case imageData
		}
		
		func encode(to encoder: Encoder) throws {
			var container = encoder.container(keyedBy: CodingKeys.self)
			switch self {
			case .url(let url): try container.encode(url, forKey: .url)
			case .imageData(let data): try container.encode(data, forKey: .imageData)
			case .blank: break
			}
		}
		
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
