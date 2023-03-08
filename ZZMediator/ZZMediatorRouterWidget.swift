//
//  ZZRouterWidget.swift
//  ZZMediator
//
//  Created by meta on 2023/2/8.
//

import Foundation

public class ZZMediatorRouterWidget{
    
    public typealias ZZRouterWidgetHandlerBlock = ([String:Any]) -> Any?
    
    public var url: URL
    public var priority: UInt
    public var handler: ZZRouterWidgetHandlerBlock
    
    init(url: URL, priority: UInt, handler: @escaping ZZRouterWidgetHandlerBlock) {
        self.url = url
        self.priority = priority
        self.handler = handler
    }
}


extension ZZMediatorRouterWidget{
    
    ///  open url   macth  register url
    /// - Parameter url: open url
    /// - Returns:  匹配结果和path参数
    /// 路径匹配规则
   public func macth(url: URL) -> (Bool,[String: String]?){
        
        let widgetPathComponents = self.url.matchPathComponents()
        let urlPathComponents = url.matchPathComponents()
        if widgetPathComponents.count != urlPathComponents.count{
            return (false,nil)
        }
        var queries:[String: String]?
        for index in 0..<widgetPathComponents.count{
            var widgetStr = widgetPathComponents[index]
            if widgetStr.hasPrefix(":"){
                if queries == nil{
                    queries = [:]
                }
                widgetStr.removeFirst()
                queries![String(widgetStr)] = urlPathComponents[index]
            }else if widgetStr != urlPathComponents[index]{
                return (false,nil)
            }
        }
        return (true,queries)
    }
}


extension URL{
    
    public func matchPathComponents() -> [String]{
        if self.pathComponents.count > 1 && self.pathComponents[0] == "/"{
            var arr = self.pathComponents
            arr.remove(at: 0)
            if let host = self.host{
                arr.insert(host, at: 0)
            }
            return arr
        }
        return self.pathComponents
    }
    
    
    public func queries() -> [String:String]?{
        guard let queryItems = URLComponents(url: self, resolvingAgainstBaseURL: true)?.queryItems else{
            return nil
        }
        var queries = [String: String]()
        queryItems.forEach { (item) in
            queries[item.name] = item.value
        }
        if queries.count > 0{
            return queries
        }
        return nil
    }
}
