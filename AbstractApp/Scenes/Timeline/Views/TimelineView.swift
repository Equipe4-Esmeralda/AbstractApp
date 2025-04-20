//
//  TimelineView.swift
//  AbstractApp
//
//  Created by Silvano Maneck Malfatti on 05/04/25.
//

import UIKit

class TimelineView: UIView {
    
    // MARK: - Constants
    
    let tableRowHeight = 120.0
    let loadingViewSize = 240.0
    
    
    // MARK: - Stored Property
    private var posts: [Post] = []
    var didSelectCell: ( ()->Void )?
    
    // MARK: - Initializers
    private lazy var loadingView = TimelineLoadingView()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier)
        tableView.rowHeight = tableRowHeight
        return tableView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.isHidden = true
        loadingView.isHidden = true
        buildLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("esta view nao pode ser inicializada")
    }
    
    func startLoading() {
        loadingView.isHidden = false
        tableView.isHidden = true
    }
    
    func showTimeline(_ posts: [Post]) {
        self.posts = posts
        loadingView.isHidden = true
        tableView.isHidden = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
}

extension TimelineView: ViewCodable {
    func buildViewHierarchy() {
        addSubview(loadingView)
        addSubview(tableView)
    }
    
    func buildViewConstraints() {
        loadingView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(loadingViewSize)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func additionalConfig() {
        self.backgroundColor = .white
    }
}

extension TimelineView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCell?()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TimelineView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier) as? PostTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(with: posts[indexPath.row])
        return cell
    }
}
