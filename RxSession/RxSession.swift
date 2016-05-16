//
//  RxSessionManager.swift
//  RxSession
//
//  Created by Lopez Valenciano, Miguel on 5/13/16.
//  Copyright © 2016 BuscoReto. All rights reserved.
//

import Foundation
import RxSwift

public class RxSession<T : RxSessionData> {
    
    let sessionIO: RxSessionIO
    
    public let rx_data: Variable<RxSessionState<T>> = Variable(RxSessionState.Unset)
    
    public init(sessionIO: RxSessionIO = DefaultSessionIO()) {
        self.sessionIO = sessionIO
    }
    
    public func save(data data: T) {
        self.sessionIO.write(data: data.data())
        self.rx_data.value = RxSessionState.Set(data)
    }
    
    public func clear(data data: T) {
        self.sessionIO.clear(keys: data.keys())
        self.rx_data.value = RxSessionState.Unset
    }
    
}