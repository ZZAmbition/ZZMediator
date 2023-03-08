//
//  ZZProtocolTests.swift
//  ZZMediator_Tests
//
//  Created by mooyoo on 2023/2/15.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

/*
 单元测试目标中设置以下内容Build Settings：
 
 Bundle Loader在
 $(BUILT_PRODUCTS_DIR)/MyExistingApp.app/MyExistingApp
 
 Test Host
 $(BUNDLE_LOADER)
 
 App Target Build Settings：
 Symbols Hidden by Default
 NO
 */

import XCTest
@testable import ZZMediator


public protocol ModuleAService: ZZMediatorModuleProtocol{}
public protocol ModuleBService: ZZMediatorModuleProtocol{}
class ModuleA: ModuleAService{
    static var shared: ZZMediatorModuleProtocol = ModuleA()
    private init(){}
    func setup() {
        print(self.self,"setup")
    }
}
class ModuleB: ModuleBService{
    static var shared: ZZMediatorModuleProtocol = ModuleB()
    private init(){}
    func setup() {
        print(self.self,"setup")
        
    }
}



final class ZZProtocolTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    //
    func testRegisterProtocol() throws {
        
        ZZMediator.register(serviceProtocol:ModuleAService.self , module: ModuleA.shared)
        if let modulea = ZZMediator.module(serviceProtocol: ModuleAService.self) as? ModuleAService{
            modulea.setup()
        }
        register(serviceProtocol: ModuleA.self)
    }
    
    func testAction() throws {
        let target = getTargetName()
        XCTAssertEqual(target, "ZZMediator_Tests")
        if let cls = NSClassFromString("ZZMediator_Tests.ModuleA") as? ZZMediatorModuleProtocol.Type{
            cls.shared.setup()
        }
     
    }
    
    func getTargetName() -> String {
        let bundle = Bundle(for: ZZProtocolTests.self)
        guard let appName = bundle.object(forInfoDictionaryKey: "CFBundleName") as? String else { return "" }
        return appName
    }
    
    
    func register(serviceProtocol: Any){
        print("\(serviceProtocol)")
    }
}
