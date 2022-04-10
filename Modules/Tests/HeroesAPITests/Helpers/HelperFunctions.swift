import Foundation

func makeMarvelCharactersJSON(_ data: [[String: Any]]) -> Data {
    let json = [
        "data": [
            "results": data
        ]
    ]
    return try! JSONSerialization.data(withJSONObject: json)
}
