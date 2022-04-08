//
//  BaseRequest.swift
//

import UIKit

let bsRequest = BaseRequest()

//typealias FinishBlock = (Any) -> ()

class BaseRequest {
    func requestWithUrl(_ urlStr: String,
                        param: [String: Any],
                        get: Bool = true,
                        token: String = "",
                        success: @escaping (Any) -> (),
                        failure: @escaping (Any) -> ()) {
        
        let bsUrl = ""
        guard var url = URL(string: bsUrl+urlStr) else {
            failure("url错误")
            return
        }
        var request: URLRequest
        if get {
            url = url.appendingQueryParameters(param)
            request = URLRequest(url: url)
        } else {
            request = URLRequest(url: url)
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: param, options: .prettyPrinted)  // Json Body
            } catch let error {
                print(error.localizedDescription)
            }
        }
        
        request.httpMethod = get ? "GET" : "POST"
        request.addValue(token, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
        
        let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?)  in
            if (error == nil) {
                print("request \(url)")
                // Success
                let statusCode = (response as! HTTPURLResponse).statusCode
                if 200 != statusCode {
                    failure("状态码\(statusCode)")
                    return
                }
                success(data as Any)
            }
            else {
                // Failure
                print("URL Session Task Failed: %@", error!.localizedDescription);
                failure(error ?? "occur some error")
            }
        })
        task.resume()
    }
}

//
// MARK: - URLQueryParameterStringConvertible
//
protocol URLQueryParameterStringConvertible {
    var queryParameters: String {get}
}
extension Dictionary : URLQueryParameterStringConvertible {
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
}
extension URL {
    func appendingQueryParameters(_ parametersDictionary : Dictionary<String, Any>) -> URL {
        let URLString : String = String(format: "%@?%@", self.absoluteString, parametersDictionary.queryParameters)
        return URL(string: URLString)!
    }
}
