

import Foundation

public enum RequestCompletionStates {
    case loading
    case success
    case noInternet
    case noData
    case failed
    case loggedOut
}

public class APIHelperFunctions {
    
    //MARK:- Shared Manager
    private static var sharedManager: APIHelperFunctions = {
        let manager = APIHelperFunctions()
        return manager
    }()
    
    open class func shared() -> APIHelperFunctions {
        return sharedManager
    }
    
    public func GET(urlString: String, params: [String:String]? ,
                    retryCount: Int = 0, fetchRequestCompletionHandler:
        @escaping ((_ status:RequestCompletionStates, _ response: Data?) -> Void) = { _,_  in }) {
        
        // Set up the URL request
        let apiURLCompnent = NSURLComponents(string: urlString)!
        var items = [URLQueryItem]()

        if params != nil {
            for (key,value) in params! {
                items.append(URLQueryItem(name: key, value: value))
            }
        }
        
        items = items.filter{!$0.name.isEmpty}

        if !items.isEmpty {
            apiURLCompnent.queryItems = items
        }
        
        guard let url = apiURLCompnent.url else {
            fetchRequestCompletionHandler(.failed, nil)
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        //Set up URLSession
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        //Create the request
        let task = session.dataTask(with: urlRequest) {
            (data, response, error) in
            
            // check for any errors
            guard error == nil else {
                
                
                if let nsError = error as NSError? {
                    switch nsError.code {
                    case NSURLErrorTimedOut, NSURLErrorCannotConnectToHost,
                         NSURLErrorNetworkConnectionLost, NSURLErrorNotConnectedToInternet:
                        fetchRequestCompletionHandler(.noInternet, nil)
                        return
                    default:
                        if retryCount > 0 {
                            self.GET(urlString: urlString, params: params,
                                     retryCount: retryCount-1,
                                     fetchRequestCompletionHandler: fetchRequestCompletionHandler)
                            return
                        } else {
                            fetchRequestCompletionHandler(.failed, nil)
                            return
                        }
                    }
                }
                
                fetchRequestCompletionHandler(.failed, nil)
                return
            }
            
            
            guard let responseData = data else {
                fetchRequestCompletionHandler(.failed, nil)
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with:
                    responseData, options: [])
                fetchRequestCompletionHandler(.success, responseData)
            } catch let parsingError {
                fetchRequestCompletionHandler(.failed, nil)
            }
            
        }
        
        task.resume()
    }
}




