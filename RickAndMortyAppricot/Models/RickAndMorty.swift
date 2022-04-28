
struct RickAndMorty: Decodable {
    let info: Info
    let results: [Result]
}

struct Info: Decodable {
    let pages: Int
    let next: String?
    let prev: String?
}

struct Result: Decodable {
    let name: String
    let species: String
    let gender: String
    let image: String
    let status: String
    let location: Location
    let episode: [String]
    let url: String
    
    var description: String {
    """
    Name: \(name)
    Species: \(species)
    Gender: \(gender)
    Status: \(status)
    Location: \(location.name)
    Episodes: \(episode.count)
    """
    }
}

struct Location: Decodable {
    let name: String
}

enum URLS: String {
    case rickAndMortyAPI = "https://rickandmortyapi.com/api/character"
}
