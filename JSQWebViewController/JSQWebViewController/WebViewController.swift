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
import WebKit

public class WebViewController: UIViewController {

    public lazy var webView: WKWebView = {
        let webView = WKWebView(frame: self.view.bounds, configuration: self.configuration)
        self.view.addSubview(webView)
        return webView
    }()

    public lazy var progressBar: UIProgressView = {
        let progressBar = UIProgressView(progressViewStyle: .Bar)
        self.view.addSubview(progressBar)
        return progressBar
    }()

    public var urlRequest: NSURLRequest {
        didSet {
            webView.loadRequest(urlRequest)
        }
    }

    private let configuration: WKWebViewConfiguration

    public init(urlRequest: NSURLRequest, configuration: WKWebViewConfiguration = WKWebViewConfiguration()) {
        self.urlRequest = urlRequest
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
    }

    public convenience init(url: NSURL) {
        self.init(urlRequest: NSURLRequest(URL: url))
    }

    public required init(coder aDecoder: NSCoder) {
        self.urlRequest = NSURLRequest(URL: NSURL(string: "")!)
        self.configuration = WKWebViewConfiguration()
        super.init(coder: aDecoder)
    }

    // MARK: View lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(urlRequest)
        progressBar.setProgress(0.5, animated: true)
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.webView.frame = self.view.bounds
        self.view.bringSubviewToFront(self.progressBar)
        self.progressBar.frame = CGRect(x: 0, y: self.topLayoutGuide.length, width: self.view.frame.size.width, height: 2)
    }



}
