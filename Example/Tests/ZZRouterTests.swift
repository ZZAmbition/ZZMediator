//
//  ZZRouterTests.swift
//  ZZMediator_Tests
//
//  Created by mooyoo on 2023/2/9.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import XCTest
@testable import ZZMediator

final class ZZRouterTests: XCTestCase {
    
    
    var widgetHandler: ZZMediatorRouterWidget.ZZRouterWidgetHandlerBlock!
    var failedHandler: ZZMediatorRouter.ZZRouterFailedOpenURLBlock!
    
    func failedRoute(url: URL){
        print("url",url)
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.widgetHandler = { params in
            print(params)
            return 123
        }
        
        self.failedHandler = failedRoute
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testURL() throws {
        let url = URL(string: "scheme://host/path/file/:name?key=value&t=xyz#home")!
        XCTAssertEqual(url.scheme, "scheme")
        XCTAssertEqual(url.host, "host")
        XCTAssertEqual(url.path, "/path/file/:name")
        XCTAssertEqual(url.query, "key=value&t=xyz")
        XCTAssertEqual(url.fragment, "home")
        XCTAssertEqual(url.pathComponents, ["/", "path", "file", ":name"])
        XCTAssertEqual(url.matchPathComponents(), ["host","path","file",":name"])
        XCTAssertEqual(url.queries(), ["key":"value","t":"xyz"])
        
        let url1 = URL(string: "/test")!
        XCTAssertNil(url1.host)
        XCTAssertEqual(url1.pathComponents, ["/", "test"])
        XCTAssertEqual(url1.path, "/test")
        XCTAssertEqual(url1.matchPathComponents(), ["test"])
        XCTAssertNil(url1.queries())
        
        let url2 = URL(string: "test")!
        XCTAssertEqual(url2.pathComponents, [ "test"])
        XCTAssertEqual(url2.path, "test")
        XCTAssertEqual(url2.matchPathComponents(), ["test"])
        XCTAssertNil(url2.queries())
        
        let url3 = URL(string: "/test/")!
        XCTAssertEqual(url1.pathComponents, url3.pathComponents)
        XCTAssertEqual(url1.path, url3.path)
        XCTAssertEqual(url3.matchPathComponents(), ["test"])
        XCTAssertNil(url3.queries())
        
        let url4 = URL(string: "/")!
        XCTAssertEqual(url4.pathComponents, ["/"])
        XCTAssertEqual(url4.path, "/")
        XCTAssertEqual(url4.matchPathComponents(), ["/"])
        XCTAssertNil(url4.queries())
    }
    

    
    func testRoute() throws{
        
        ZZMediatorRouter.registerURL(urlString: "/", handler: widgetHandler)
        let result = ZZMediatorRouter.openURL(urlString: "/")
        XCTAssertEqual(result as! Int, 123)
        let result1 = ZZMediatorRouter.openURL(urlString: "test")
        XCTAssertNil(result1)
        ZZMediatorRouter.registerURL(urlString: "home/recomand/:path", handler: widgetHandler)
        ZZMediatorRouter.openURL(urlString: "scheme://home/recomand/?id=11&address=guangdong")
    }
   
}



