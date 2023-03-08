//
//  ZZMediatorModuler.swift
//  ZZMediator
//
//  Created by meta on 2023/2/15.
//

import Foundation

public class ZZMediatorModuler{
    
    //singleton
    public static let shared = ZZMediatorModuler()
    private init(){}
    
    private var modulesDict:[String:ZZMediatorModuleProtocol] = [:]
    private var modules:[ZZMediatorModuleProtocol] = []
    
    
    /// 注册公共协议,绑定对应实现的module
    /// - Parameters:
    ///   - serviceProtocol: 公共协议
    ///   - module: 协议对应的实现类
    public class func register<P>(serviceProtocol: P.Type, module: ZZMediatorModuleProtocol){
        let protocolStr = "\(serviceProtocol.self)"
        shared.modulesDict[protocolStr] = module
        shared.modules.append(module)
        shared.modules.sort{ $0.priority > $1.priority}
    }
    
    /// 获取注册协议对应的module
    /// - Parameter serviceProtocol: 公共协议
    /// - Returns: 协议对应的实现类
    public class func module<P>(serviceProtocol: P.Type) ->ZZMediatorModuleProtocol?{
        let protocolStr = "\(serviceProtocol.self)"
        return shared.modulesDict[protocolStr]
    }
    
    
    public class func setupAllModules(){
        shared.modules.forEach { module in
            module.setup()
        }
    }
}
