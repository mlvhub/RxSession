//
//  TestSessionData.swift
//  RxSession
//
//  Created by Lopez Valenciano, Miguel on 5/15/16.
//  Copyright © 2016 BuscoReto. All rights reserved.
//

import RxSession

// Dummy implementation for tests purposes
class TestSessionData : RxSessionData {
    
    var sessionData: [String: String]
    
    init(sessionData: [String: String] = ["token": "myuserid", "name": "Miguel"]) {
        self.sessionData = sessionData
    }
    
    func data() -> [String: String] {
        return sessionData
    }
    
    func data(data: [String: String]) {
        self.sessionData = data
    }
    
    func keys() -> [String] {
        return Array(self.data().keys)
    }
}

func ==(rhs: TestSessionData, lhs: TestSessionData) -> Bool {
    return rhs.data() == lhs.data()
}