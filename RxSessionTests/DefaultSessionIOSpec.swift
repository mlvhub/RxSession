//
//  DefaultSessionIOSpec.swift
//  RxSession
//
//  Created by Lopez Valenciano, Miguel on 5/13/16.
//  Copyright © 2016 BuscoReto. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import RxSession

class DefaultSessionIOSpec: QuickSpec {
    
    let sessionData: [String: String] = ["token": "myuserid", "name": "Miguel"]
    var sessionKeys: [String] {
        get {
            return Array(sessionData.keys)
        }
    }
    
    override func spec() {
        var sut: DefaultSessionIO!
        
        beforeEach {
            sut = DefaultSessionIO()
            // Make sure we start each test with a clear session
            sut.clear(keys: self.sessionKeys)
        }
        afterEach {
            sut = nil
        }
        
        it("should not be have data at the beginning") {
            let storedData: [String: String]? = sut.read(keys: self.sessionKeys)
            expect(storedData).to(beNil())
        }
        
        it("should be able to write session data") {
            sut.write(data: self.sessionData)
            
            let storedData: [String: String] = sut.read(keys: self.sessionKeys)!
            let values = Array(storedData.values)
            expect(values.count) == 2
            expect(values).to(equal(["myuserid", "Miguel"]))
        }
        
        it("should be able to clear session data") {
            sut.write(data: self.sessionData)
            
            sut.clear(keys: self.sessionKeys)
            
            let storedData: [String: String]? = sut.read(keys: self.sessionKeys)
            expect(storedData).to(beNil())
        }
    }
    
}