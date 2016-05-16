//
//  RxSessionWriter.swift
//  RxSession
//
//  Created by Lopez Valenciano, Miguel on 5/13/16.
//  Copyright © 2016 BuscoReto. All rights reserved.
//

import Foundation

public protocol RxSessionIO {
    func write(data data: [String: String])
    func read(keys keys: [String]) -> [String: String]?
    func clear(keys keys: [String])
}

extension RxSessionIO {
    public func write(data data: [String: String]) {
        let defaults = NSUserDefaults.standardUserDefaults()
        data.forEach { (key, value) in
            defaults.setObject(value, forKey: key)
        }
    }
    
    public func read(keys keys: [String]) -> [String: String]?
    {
        let defaults = NSUserDefaults.standardUserDefaults()
        
        // Check if all keys have values, otherwise return nil
        if (keys.map({ defaults.objectForKey($0) == nil }).reduce(false, combine: or) ) {
            return nil
        }
        
        let dicts: [[String: String]] = keys.map { key in
            return [key: defaults.objectForKey(key) as! String]
        }
        return dicts.reduce([:]) { (dict1, dict2) -> [String: String] in
            
            return dict1 + dict2
        }
    }
    
    public func clear(keys keys: [String]) {
        let defaults = NSUserDefaults.standardUserDefaults()
        keys.forEach { key in
            defaults.removeObjectForKey(key)
        }
    }
}

public struct DefaultSessionIO : RxSessionIO {
    
}

func + <K,V>(left: Dictionary<K,V>, right: Dictionary<K,V>)
    -> Dictionary<K,V>
{
    var map = Dictionary<K,V>()
    for (k, v) in left {
        map[k] = v
    }
    for (k, v) in right {
        map[k] = v
    }
    return map
}

public func or(a: Bool, b: Bool) -> Bool {
    return a || b
}