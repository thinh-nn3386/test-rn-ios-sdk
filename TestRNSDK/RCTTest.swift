//
//  RCTTest.swift
//  RNSDKExample
//
//  Created by Nguyen Thinh on 08/05/2024.
//

import Foundation
import Security


@objc(NativeModuleTest)
class NativeModuleTest: NSObject {
  @objc static func requiresMainQueueSetup() -> Bool {
      return true
  }
  
  @objc func sum(
    _ num1 : NSNumber,
    num2: NSNumber,
    callback: RCTResponseSenderBlock
  ) {
    callback([num1.intValue + num2.intValue])
  }
}

