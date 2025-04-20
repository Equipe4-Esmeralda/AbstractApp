//
//  ViewCodable.swift
//  Abstract
//
//  Created by Silvano Maneck Malfatti on 03/04/25.
//

import Foundation

public protocol ViewCodable: AnyObject {
    func buildViewHierarchy()
    func buildViewConstraints()
    func additionalConfig()
    func buildLayout()
}

public extension ViewCodable {
    func buildLayout() {
        buildViewHierarchy()
        buildViewConstraints()
        additionalConfig()
    }
    func additionalConfig() { /* Intentionally unimplemented */ }
}
