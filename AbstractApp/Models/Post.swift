import Foundation

struct Post: Decodable {
    let title: String
    let content: String
    let date: Date
    let imageName: String? // nome da imagem no Assets (opcional)
    
    // Custom coding keys to map API response to our model
    enum CodingKeys: String, CodingKey {
        case title
        case content = "body"
        case date
        case imageName
    }
    
    // Custom initializer to handle decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        content = try container.decode(String.self, forKey: .content)
        
        // For date, we'll use the current date since the API doesn't provide one
        date = Date()
        
        // For imageName, we'll use a default value since the API doesn't provide one
        imageName = nil
    }
    
    // Regular initializer for creating posts manually
    init(title: String, content: String, date: Date, imageName: String?) {
        self.title = title
        self.content = content
        self.date = date
        self.imageName = imageName
    }
} 