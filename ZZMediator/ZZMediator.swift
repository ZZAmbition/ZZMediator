//
//  ZZMediator.swift
//  Pods-ZZMediator_Example
//


import Foundation



public class ZZMediator{
    

}


//MARK: - 路由注册
extension ZZMediator{
    
    public class func registerURL(urlString: String, priority: UInt = 0, handler: @escaping ZZMediatorRouterWidget.ZZRouterWidgetHandlerBlock){
        ZZMediatorRouter.registerURL(urlString: urlString, priority: priority, handler: handler)
    }
    
    public class func openURL(urlString: String, parameters: [String:Any]? = nil, handler: ZZMediatorRouter.ZZRouterSuccessedOpenURLBlock? = nil) ->Any?{
        ZZMediatorRouter.openURL(urlString: urlString, parameters: parameters, handler: handler)
    }
}

//MARK: -  协议注册
extension ZZMediator{
    
    public class func register<P>(serviceProtocol: P.Type, module: ZZMediatorModuleProtocol){
        ZZMediatorModuler.register(serviceProtocol: serviceProtocol, module: module)
    }
    
    public class func module<P>(serviceProtocol: P.Type) ->ZZMediatorModuleProtocol?{
        ZZMediatorModuler.module(serviceProtocol: serviceProtocol)
    }
    
    public class func setupAllModules(){
        ZZMediatorModuler.setupAllModules()
    }
}



 
