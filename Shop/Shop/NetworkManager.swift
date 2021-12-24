import Foundation

enum NetworkError: Error, Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.noData, .noData):
            return true
        case (let .error(error1), let error(error2)):
            return error1.localizedDescription == error2.localizedDescription
        case (.malformedData, .malformedData):
              return true
        default:
            return false
        }
    }

    case noData
    case error(Error)
    case malformedData
}

// Excercise: Create a networking manager to fetch data from an API endpoint
//
// Requirement:
// - Use URLSession for this excercise.
// - Return a NetworkError if error occurs or not data.
//
// Hint: Decodable, URLSession, URLSessionConfiguration, Decoder
protocol NetworkManaging {
    func data<T: Decodable>(from url: URL, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)
}

public class NetworkManager: NetworkManaging {

    init() {
        
    }

    func data<T: Decodable>(from url: URL, type: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        let session = URLSession.shared

        let task = session.dataTask(with: url) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                return
            }

//            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
//                    print("Server error!")
//                return
//            }

            do {
                let jsonData = try JSONDecoder().decode(Shop.self, from: data!)

                completion(Result<T, NetworkError>.success(jsonData as! T))
            } catch {
                completion(Result<T, NetworkError>.failure(NetworkError.malformedData))
                print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}
