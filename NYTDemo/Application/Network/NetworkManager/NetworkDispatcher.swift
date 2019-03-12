import UIKit

/// Network dispatcher for dispatching network requests.
protocol NetworkDispatcher {
    
    /// Function for handling network requests.
    ///
    /// - Parameters:
    ///   - request: Request data structure for nework requests.
    ///   - onSuccess: complition block for success.
    ///   - onError: complition block for error.
    func dispatch(request: HTTPRequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void)
}

/// Network dispatcher implementation.
struct URLSessionNetworkDispatcher: NetworkDispatcher {
    internal static let instance = URLSessionNetworkDispatcher()
    private init() {}
    
    /// Function for handling network requests.
    ///
    /// - Parameters:
    ///   - request: Request data structure for nework requests.
    ///   - onSuccess: complition block for success.
    ///   - onError: complition block for error.
    internal func dispatch(request: HTTPRequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void) {
        guard var urlComponent = URLComponents(string: request.path) else {
            onError(HTTPError.invalidURL)
            return
        }
        if let params = request.params {
            urlComponent.queryItems = params.map { (arg) -> URLQueryItem in
                let (key, value) = arg
                return URLQueryItem(name: key, value: value)
            }
        }
        urlComponent.queryItems?.append(URLQueryItem(name:"api-key", value: "rIOcgUbDpeTsSonpNOl0xl9VnDnWnGzW"))
        guard let url = urlComponent.url else {
            onError(HTTPError.invalidURL)
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                onError(error)
                return
            }
            guard let _data = data else {
                onError(HTTPError.noData)
                return
            }
            onSuccess(_data)
            }.resume()
    }
}
