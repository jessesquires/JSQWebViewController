//
//  Created by Jesse Squires
//  http://www.jessesquires.com
//
//
//  Documentation
//  http://www.jessesquires.com/JSQWebViewController
//
//
//  GitHub
//  https://github.com/jessesquires/JSQWebViewController
//
//
//  License
//  Copyright (c) 2015 Jesse Squires
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

import UIKit
import XCTest
import WebKit

@testable
import JSQWebViewController


class JSQWebViewControllerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func test_thatWebViewController_InitializesSuccessfully() {
        let webVC = WebViewController(url: NSURL(string: "http://jessesquires.com")!)
        XCTAssertNotNil(webVC);

        XCTAssertNotNil(webVC.webView)
        XCTAssertNotNil(webVC.progressBar)
        XCTAssertNotNil(webVC.urlRequest)

        XCTAssertEqual(webVC.displaysWebViewTitle, false)
    }
}
