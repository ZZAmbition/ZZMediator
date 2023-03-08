//
//  ZZMediatorProtocol.swift
//  ZZMediator
//

import Foundation


//注册module协议规范
public protocol ZZMediatorModuleProtocol{
    
    //单例
    static var shared: ZZMediatorModuleProtocol { get  }
    
    //优先级
    var priority: UInt { get }
    
    //启动模块
    func setup()
    
}


extension ZZMediatorModuleProtocol{
    
    public var priority: UInt{
        return 0
    }
    
}
