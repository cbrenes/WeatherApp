//
//  DispatchQueueHelper.swift
//  WeatherApp
//
//  Created by Cesar Brenes on 13/4/22.
//

import Foundation

/// This class allows to run the tests whithout need to put delays, because if the current thread is the main, the method will execute the code in the same thread without need to create a new one
class DispatchQueueHelper {
    class func executeInMainThread(completion: @escaping () -> Void) {
        if Thread.isMainThread {
            completion()
        } else {
            DispatchQueue.main.async(execute: completion)
        }
    }
}
