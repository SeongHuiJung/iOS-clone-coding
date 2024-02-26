//
//  NetworkManager.swift
//  MovieApp
//
//  Created by 정성희 on 2024/02/25.
//

import Foundation

enum MovieAPIType {
    case justURL(urlString: String) //이미지
    case searchMovie(querys: [URLQueryItem]) //검색
}

enum MovieAPIError: Error{
    case badURL
}

class NetworkManager {
    //only url
    //url + param
    
    typealias NetworkCompletion = (_ data: Data?, _ reponse: URLResponse?, _ error: Error?) -> Void
    
    func request(type: MovieAPIType, completion: @escaping NetworkCompletion) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        
        do {
            let request = try buildRequest(type: type)
            
            session.dataTask(with: request) { data, response, error in
                print ((response as! HTTPURLResponse).statusCode)
                
                completion(data,response,error)
                
                
                
            }.resume() //마지막에 항상 실행, 그리고 끝내기까지 해주는것 잊지 말기
            session.finishTasksAndInvalidate()
            
        }catch {
            print(error)
        }
        
           
        
        
        // 만약 if 문에 안걸려서 completion(UIImage(data: hasData)) 를 실행하지 못한다면 마지막에 nil이라도 completion 을 해줘야함. 하지 않으면 계속 메모리를 잡아먹고 있을 것임

    }
    
    //반환할게 있는 함수인데 성공했을 시 값을 반환해주는 식으로 짠다면, 실패했을 경우를 따지지 않아서 오류를 발생시킴
    //해당 경우는 두가지 방법으로 해결할 수 있음
    //1. 반환형을 optional 로 설정해 실패한 경우 return nil 를 하는 것
    //2. throws 를 이용 : 실패했을 경우 throws 를 실행한다. throws  는 Error 프로토콜을 준수한 enum 으로 미리 설정해 두어야 한다 -> 여기서는 해당 방법으로 진행하겠음
    func buildRequest(type: MovieAPIType) throws -> URLRequest {
        switch type {
        case .justURL(urlString: let urlString):
            guard let hasURL = URL(string: urlString) else {
                throw MovieAPIError.badURL
            }
            var request = URLRequest(url: hasURL)
            request.httpMethod = "GET"
            return request
            
        case .searchMovie(querys: let querys):
            var components = URLComponents(string: "https://itunes.apple.com/search")
            components?.queryItems = querys
            
            guard let hasUrl = components?.url else{
                throw MovieAPIError.badURL
            }
            var request = URLRequest(url: hasUrl)
            request.httpMethod = "GET"
            return request
        }
    }
}
