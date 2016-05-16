//
//  RxSessionDataSpec.swift
//  RxSession
//
//  Created by Lopez Valenciano, Miguel on 5/15/16.
//  Copyright © 2016 BuscoReto. All rights reserved.
//

import Quick
import Nimble
import RxBlocking
import RxSwift
import RxCocoa
import RxTests
@testable import RxSession

class RxSessionDataSpec: QuickSpec {
    
    override func spec() {
        
        var sut: TestSessionData!
        
        beforeEach {
            sut = TestSessionData()
        }
        
        afterEach {
            sut = nil
        }
        
        it("should be able to return its keys correctly") {
            expect(sut.keys()) == ["token", "name"]
        }
        
        it("should be able to determine whether two RxSessionDatas are equal correctly") {
            var other = TestSessionData()
            
            expect(sut) == other
            
            other = TestSessionData(sessionData: ["token": "myuserid2", "name": "Alejandro"])
            
            expect(sut) != other
        }
    }
}