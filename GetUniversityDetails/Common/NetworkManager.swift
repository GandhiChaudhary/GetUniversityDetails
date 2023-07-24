
import Foundation

enum CustomError: Error {
    case BadURL
    case NoData
    case DecodingError
}

class NetworkManager {
    let apiHandler: APIHandlerDelegate
    let responseHandler: ResponseHandlerDelegate
    
    init(apiHandler: APIHandlerDelegate = APIHandler(),
         responseHandler: ResponseHandlerDelegate = ResponseHandler()) {
        self.apiHandler = apiHandler
        self.responseHandler = responseHandler
    }
    
    func fetchRequest<T: Codable>(type: T.Type, url: URL, completion: @escaping(Result<T, CustomError>) -> Void) {
        apiHandler.fetchData(url: url) { result in
            switch result {
            case .success(let data):
                self.responseHandler.fetchModel(type: type, data: data) { decodedResult in
                    switch decodedResult {
                    case .success(let model):
                        completion(.success(model))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
}
