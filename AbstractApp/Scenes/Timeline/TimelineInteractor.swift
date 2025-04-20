//
//  TimelineInteractor.swift
//  AbstractApp
//
//  Created by Silvano Maneck Malfatti on 05/04/25.
//

import Foundation


class TimelineInteractor {
    
    private let service: TimelineService
    private let presenter: TimelinePresenter
    
    init(service: TimelineService, presenter: TimelinePresenter) {
        self.service = service
        self.presenter = presenter
    }
}

extension TimelineInteractor {
    func loadTimeline() {
        presenter.startLoading()
        service.fetchTimeline { [weak self] result in
            switch(result) {
            case .success(let posts):
                self?.presenter.presentTimeline(with: posts)
            case .failure(let error):
                print("Apresentar o erro")
                //self?.presenter.presentError()
            }
        }
    }
}
