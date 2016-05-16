//
//  SessionData.swift
//  RxSession
//
//  Created by Lopez Valenciano, Miguel on 5/15/16.
//  Copyright © 2016 BuscoReto. All rights reserved.
//

import Foundation

public protocol RxSessionData : Equatable {
    func data(data: [String: String])
    func data() -> [String: String]
    func keys() -> [String]
}

extension RxSessionData {
    func keys() -> [String] {
        return Array(self.data().keys)
    }
}

func ==<T : RxSessionData>(lhs: T, rhs: T) -> Bool {
    return lhs.data() == rhs.data()
}