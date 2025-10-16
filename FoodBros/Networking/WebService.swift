//
//  WebService.swift
//  FoodBros
//
//  Created by Rifluxyss on 12/09/25.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum AppEnvironment {
    case development
    case production
    
    var url: String {
        switch self {
        case .development:
            return "http://192.168.0.246:8080/api/"
            
        default:
            return ""
        }
    }
}

fileprivate struct OptionalCodable: Codable {
    //Use to be able to pass nil
}

class WebService {
    
    typealias CompletionHandler = (_ responseBody: Any?, _ error: Error?) -> Void
    
    private var url: String = ""
    private var path: String = ""
    private var method: HTTPMethod = .get
    private var body: Data?
    
    // MARK: - Set URL, Method, Body
    
    func setURL(url: String = AppEnvironment.development.url) -> WebService {
        self.url = url
        return self
    }
    
    func setMethod(_ method: HTTPMethod) -> WebService {
        self.method = method
        return self
    }
    
    func setPath(path: String) -> WebService {
        self.path = path
        return self
    }
    
    func setBody<T: Encodable>(_ body: T) -> WebService {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        self.body = try? encoder.encode(body)
        return self
    }
    
    func setBody(_ body: Any) -> WebService {
        if let data = body as? Data {
            self.body = data
        } else {
            self.body = try? JSONSerialization.data(withJSONObject: body, options: [])
        }
        return self
    }
    
    private func createRequest() -> URLRequest? {
        if self.url == "" {
            _ = setURL()
        }
        url += self.path
        
        guard let baseURL = URL(string: self.url) else {
            return nil
        }
        
        var request = URLRequest(url: baseURL)
        request.httpMethod = method.rawValue
        request.httpBody = body
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return request
    }
    
    // MARK: - Execute Request
    
    func build(completion: @escaping CompletionHandler) {
        guard let request = createRequest() else {
            return
        }
        
        makeRequest(request, OptionalCodable.self, completion)
    }
    
    func build<T: Codable>(type: T.Type, completion: @escaping CompletionHandler) {
        guard let request = createRequest() else {
            return
        }
        
        makeRequest(request, type, completion)
    }
    
    private func makeRequest<T: Codable>(_ request: URLRequest, _ type: T.Type?, _ completion: @escaping CompletionHandler) {
        let session = URLSession.shared
        let dataTask: URLSessionDataTask?
        
        dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            self.processResponse(type, request, data, response, error, completion: completion)
        })
        dataTask?.resume()
    }
    
    private func processResponse<T: Codable>(_ type: T.Type?, _ request: URLRequest, _ data: Data?, _ response: URLResponse?, _ error: Error?, completion: @escaping CompletionHandler) {
        DispatchQueue.main.async {
            // Handle network error first
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "No data received", code: 0))
                return
            }
            
            // Print request and response for debugging
            self.printRequestInfo(request: request, responseData: data)
            
            do {
                if let type = type, type != OptionalCodable.self {
                    // Decode to Codable type
                    let decodedObject = try JSONDecoder().decode(type, from: data)
                    completion(decodedObject, nil)
                } else {
                    // Decode to raw JSON
                    let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    completion(jsonObject, nil)
                }
            } catch {
                completion(nil, error)
            }
        }
    }

    private func printRequestInfo(request: URLRequest, responseData: Data?) {
        print("----- HTTP Request Info -----")
        print("Method: \(request.httpMethod ?? "N/A")")
        print("URL: \(request.url?.absoluteString ?? "N/A")")
        
        if let headers = request.allHTTPHeaderFields {
            print("Headers: \(headers)")
        }
        
        if let body = request.httpBody {
            if let jsonBody = try? JSONSerialization.jsonObject(with: body, options: []) {
                print("Request Body (JSON): \(jsonBody)")
            } else {
                print("Request Body: \(String(data: body, encoding: .utf8) ?? "N/A")")
            }
        }
        
        if let data = responseData {
            if let jsonResponse = try? JSONSerialization.jsonObject(with: data, options: []) {
                print("Response (JSON): \(jsonResponse)")
            } else {
                print("Response Data: \(String(data: data, encoding: .utf8) ?? "N/A")")
            }
        } else {
            print("Response: No Data")
        }
        
        print("-----------------------------\n\n")
    }
}
