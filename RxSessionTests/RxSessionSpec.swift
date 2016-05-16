//
//  RxSessionSpec.swift
//  RxSession
//
//  Created by Lopez Valenciano, Miguel on 5/13/16.
//  Copyright © 2016 BuscoReto. All rights reserved.
//

import Quick
import Nimble
import RxBlocking
import RxSwift
import RxCocoa
import RxTests
@testable import RxSession

class RxSessionSpec: QuickSpec {
    
    override func spec() {
        
        let sessionData: TestSessionData = TestSessionData()
        
        var sut: RxSession<TestSessionData>!
        var scheduler: TestScheduler!
        var disposeBag: DisposeBag!
        
        beforeEach {
            scheduler = TestScheduler(initialClock: 0)
            driveOnScheduler(scheduler) {
                sut = RxSession()
            }
            disposeBag = DisposeBag()
        }
        
        afterEach {
            scheduler = nil
            sut = nil
            disposeBag = nil
        }
        
        it("should not have data at the beginning") {
            let observer = scheduler.createObserver(RxSessionState<TestSessionData>)

            sut.rx_data.asObservable().subscribe(observer).addDisposableTo(disposeBag)
            
            scheduler.start()
            
            let expectedEvents: [Recorded<Event<RxSessionState<TestSessionData>>>] = [
                next(0, RxSessionState.Unset)
            ]
            
            XCTAssertEqual(observer.events, expectedEvents)

        }
        
        it("should be able to save the session data") {
            let observer = scheduler.createObserver(RxSessionState<TestSessionData>)
            
            scheduler.scheduleAt(100) {
                sut.rx_data.asObservable().subscribe(observer).addDisposableTo(disposeBag)
            }
            
            scheduler.scheduleAt(200) {
                sut.save(data: sessionData)
            }
            
            scheduler.start()
            
            let expectedEvents: [Recorded<Event<RxSessionState<TestSessionData>>>] = [
                next(100, RxSessionState.Unset),
                next(200, RxSessionState.Set(sessionData))
            ]
            
            XCTAssertEqual(observer.events, expectedEvents)

        }
        
        it("should be able to clear data") {
            let observer = scheduler.createObserver(RxSessionState<TestSessionData>)
            
            scheduler.scheduleAt(100) {
                sut.rx_data.asObservable().subscribe(observer).addDisposableTo(disposeBag)
            }
            
            scheduler.scheduleAt(200) {
                sut.save(data: sessionData)
            }
            
            scheduler.scheduleAt(300) {
                sut.clear(data: sessionData)
            }
            
            scheduler.start()
            
            let expectedEvents: [Recorded<Event<RxSessionState<TestSessionData>>>] = [
                next(100, RxSessionState.Unset),
                next(200, RxSessionState.Set(sessionData)),
                next(300, RxSessionState.Unset)
            ]
            
            XCTAssertEqual(observer.events, expectedEvents)
        }
    }

}




