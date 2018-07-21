//
//  MockService.swift
//  GYG
//
//  Created by Mohamed Hamed on 7/21/18.
//  Copyright © 2018 Hamed. All rights reserved.
//


import Foundation

class MockService {
    
    var mockSession:DHURLSession = URLSession(configuration: .default)
    
    func createReview(review: Review,
                      onSuccess: @escaping (Review) -> (),
                      onFailure: @escaping (Error) -> ()) {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "ReviewMockResponse", ofType: "json")
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!), options: .alwaysMapped)
        
        let url = URL(string: "https://itunes.apple.com")
        let urlResponse = HTTPURLResponse(url: url!, statusCode: 200, httpVersion: nil, headerFields: nil)
        mockSession = URLSessionMock(data: data, response: urlResponse, error: nil)
        
        let task = mockSession.dataTask(with: url!) { (data, response, error) in
            guard error == nil else  {
                onFailure(error!)
                return
            }
            if let status = (response as? HTTPURLResponse)?.statusCode {
                if status == 200 {
                    do {
                        let review = try JSONDecoder().decode(Review.self, from: data!)
                        onSuccess(review)
                    } catch let jsonErr {
                        onFailure(jsonErr)
                    }
                }
            }
        }
        task.resume()
    }
}

