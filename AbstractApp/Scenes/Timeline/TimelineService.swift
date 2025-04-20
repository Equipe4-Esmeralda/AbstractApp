//
//  TimelineService.swift
//  AbstractApp
//
//  Created by Silvano Maneck Malfatti on 05/04/25.
//

import Foundation

typealias TimelineFetchCompletion = (Result<[Post], Error>) -> Void

class TimelineService {
    
    private let url = "https://jsonplaceholder.typicode.com/posts"
    
    func fetchTimeline(completion: @escaping TimelineFetchCompletion) {
        ServiceManager.request(urlString: url, method: .get) { result in
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                completion(result)
            }
        }
    }
}
