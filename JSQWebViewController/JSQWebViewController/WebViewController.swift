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


private let TitleKeyPath = "title"

private let EstimatedProgressKeyPath = "estimatedProgress"


///  An instance of `WebViewController` displays interactive web content.
public class WebViewController: UIViewController {

    // MARK: Properties

    public var webView: WKWebView {
        get {
            return _webView
        }
    }

    public var progressBar: UIProgressView {
        get {
            return _progressBar
        }
    }

    public var urlRequest: NSURLRequest {
        didSet {
            webView.loadRequest(urlRequest)
        }
    }

    private lazy var _webView: WKWebView = { [unowned self] in

        // FIXME: prevent Swift bug, lazy property initialized twice from `init(coder:)`
        // return existing webView if webView already added
        let views = self.view.subviews.filter {$0 is WKWebView } as! [WKWebView]
        if views.count != 0 {
            return views.first!
        }

        let webView = WKWebView(frame: self.view.bounds, configuration: self.configuration)
        self.view.addSubview(webView)
        webView.addObserver(self, forKeyPath: TitleKeyPath, options: .New, context: nil)
        webView.addObserver(self, forKeyPath: EstimatedProgressKeyPath, options: .New, context: nil)
        return webView
        }()

    private lazy var _progressBar: UIProgressView = { [unowned self] in
        let progressBar = UIProgressView(progressViewStyle: .Bar)
        progressBar.backgroundColor = .clearColor()
        progressBar.trackTintColor = .clearColor()
        self.view.addSubview(progressBar)
        return progressBar
        }()

    private let configuration: WKWebViewConfiguration


    // MARK: Initialization

    public init(urlRequest: NSURLRequest, configuration: WKWebViewConfiguration = WKWebViewConfiguration()) {
        self.configuration = configuration
        self.urlRequest = urlRequest
        super.init(nibName: nil, bundle: nil)
    }

    public convenience init(url: NSURL) {
        self.init(urlRequest: NSURLRequest(URL: url))
    }

    public required init(coder aDecoder: NSCoder) {
        self.configuration = WKWebViewConfiguration()
        self.urlRequest = NSURLRequest(URL: NSURL(string: "")!)
        super.init(coder: aDecoder)
    }

    deinit {
        webView.removeObserver(self, forKeyPath: TitleKeyPath, context: nil)
        webView.removeObserver(self, forKeyPath: EstimatedProgressKeyPath, context: nil)
    }


    // MARK: View lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()
        title = urlRequest.URL?.absoluteString
        webView.loadRequest(urlRequest)
    }

    public override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        webView.stopLoading()
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.webView.frame = self.view.bounds
        self.view.bringSubviewToFront(self.progressBar)
        self.progressBar.frame = CGRect(x: 0, y: self.topLayoutGuide.length, width: self.view.frame.size.width, height: 2)
    }


    // MARK: KVO

    public override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if object as? NSObject == webView {
            switch keyPath {
            case TitleKeyPath:
                title = webView.title

            case EstimatedProgressKeyPath:
                progressBar.setProgress(Float(webView.estimatedProgress), animated: true)
                let completed = webView.estimatedProgress == 1.0
                progressBar.hidden = completed
                UIApplication.sharedApplication().networkActivityIndicatorVisible = !completed

            default: break
            }
        }
        else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
}
