//
//  ZZRouter.swift
//  ZZMediator
//
//  Created by meta on 2023/2/8.
//

import Foundation

public class ZZMediatorRouter{
    
    /// 固定参数key
    public enum ParametersKey: String{
        case successedOpenURLBlock = "ZZRouterSuccessedOpenURLBlock"
    }
    public typealias ZZRouterFailedOpenURLBlock = (URL) -> Void
    public typealias ZZRouterSuccessedOpenURLBlock = ([String:Any]) -> Void
    
    //singleton
    public static let shared = ZZMediatorRouter()
    private init(){}
    
    public var failedOpenURLHandler: ZZRouterFailedOpenURLBlock?
    private var routes:[ZZMediatorRouterWidget] = []
   
    
    public class func registerURL(urlString: String, priority: UInt = 0, handler: @escaping ZZMediatorRouterWidget.ZZRouterWidgetHandlerBlock){
        guard let url = URL(string: urlString) else{
            zzLogPrint("register url route failed ",  "[\(urlString)]")
            return
        }
        let widget = ZZMediatorRouterWidget(url: url, priority: priority, handler: handler)
        shared.routes.append(widget)
        shared.routes.sort { $0.priority > $1.priority}
    }
    
    
    public class func openURL(urlString: String, parameters: [String:Any]? = nil, handler: ZZRouterSuccessedOpenURLBlock? = nil) ->Any?{
        guard let url = URL(string: urlString) else{
            zzLogPrint("open url route failed ",  "[\(urlString)]")
            return nil
        }
        for widget in shared.routes {
            let macthResult = widget.macth(url: url)
            if macthResult.0{
                var fixParams: [String : Any] = [:]
                // 复杂参数
                if let params = parameters{
                    params.forEach { key,value in
                        fixParams[key] = value
                    }
                }
                // path参数
                if let pathParams = macthResult.1{
                    pathParams.forEach { key,value in
                        fixParams[key] = value
                    }
                }
                // query参数
                if let queryParams = url.queries(){
                    queryParams.forEach { key,value in
                        fixParams[key] = value
                    }
                }
                // 固定参数
                if let openHandler = handler{
                    fixParams[ParametersKey.successedOpenURLBlock.rawValue] = openHandler
                }
                zzLogPrint("open url route successed ", "[\(urlString)]")
                return widget.handler(fixParams)
            }
        }
        // 匹配失败
        if let failedHandler = shared.failedOpenURLHandler{
            failedHandler(url)
        }
        zzLogPrint("open url route ummatched ", "[\(urlString)]")
        return nil
    }
}


private func zzLogPrint(_ items: Any...){
    print("[ZZRouter Log]: ",items)
}
