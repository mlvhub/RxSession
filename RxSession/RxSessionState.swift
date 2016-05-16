//
//  SessionState.swift
//  RxSession
//
//  Created by Lopez Valenciano, Miguel on 5/16/16.
//  Copyright © 2016 BuscoReto. All rights reserved.
//

import Foundation

public enum RxSessionState<Element: RxSessionData> : Equatable {
    case Set(Element)
    case Unset
}

public func ==<Element: RxSessionData>(rhs: RxSessionState<Element>, lhs: RxSessionState<Element>) -> Bool {
    switch (rhs, lhs) {
    case (.Set(let data1), .Set(let data2)):
        return data1 == data2
    case (.Unset, .Unset):
        return true
    default:
        return false
    }
}