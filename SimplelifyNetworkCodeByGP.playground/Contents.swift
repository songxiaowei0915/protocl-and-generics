import Foundation

enum Level: Int {
    case beginner = 1, intermediate, advanced
}

class Episode {
    typealias EpisodeInfo = [String: String]
    
    var level: Level
    var title: String
    var urls : EpisodeInfo
    
    init(level: Level, title: String, urls: EpisodeInfo) {
        self.level = level
        self.title = title
        self.urls = urls
    }
    
    convenience init?(response: [String: Any]) {
        guard let levelValue = response["level"] as? Int,
              let level = Level(rawValue: levelValue),
              let title = response["title"] as? String,
              let urls = response["urls"] as? EpisodeInfo else {
            return nil
        }
        
        self.init(level: level, title: title, urls: urls)
    }
}

struct Resource<T> {
    let path: URL
    let parser: (Any) -> T?
}

extension Resource {
    func syncLoad(callback: (T?) -> Void) {
        let resourceData = try? Data(contentsOf: path)
        
        let jsonRoot = resourceData.flatMap {
            try? JSONSerialization.jsonObject(with:$0)
        }
        
        callback(jsonRoot.flatMap(parser))
    }
    
    func asyncLoad(callback: @escaping (T?) -> Void) {
        let session = URLSession.shared
        session.dataTask(with: path) {
            resourceData, _, _ in
            let jsonRoot = resourceData.flatMap {
                try? JSONSerialization.jsonObject(with:$0)
            }
            
            callback(jsonRoot.flatMap(self.parser))
        }.resume()
    }
}


typealias JSONObj = [String: Any]
let episodesUrl = URL(string: "http://api.boxue.io/v1/episodes")!

func getResource<T>(at path:URL, parse: (Any) -> T?,
                 callback: (T?) -> Void) {
    let resourceData = try? Data(contentsOf: path)
    
    let jsonRoot = resourceData.flatMap {
        try? JSONSerialization.jsonObject(with:$0)
    }
    
    callback(jsonRoot.flatMap(parse))
}

func parseEpisodes(jsonRoot: Any) -> [Episode]? {
    var episodes: [Episode]? = nil

    if let jsonRoot = (jsonRoot as? JSONObj),
       let episodeInfo = (jsonRoot["episodes"] as? [JSONObj]) {
        episodes = episodeInfo.map {
            Episode.init(response: $0)
        }
        .filter { $0 != nil }
        .map { $0!}
    }
    
    return episodes
}

let episodeResource: Resource<[Episode]> = Resource(path: episodesUrl, parser: parseEpisodes)
episodeResource.syncLoad(callback: { print($0 ?? "")})
