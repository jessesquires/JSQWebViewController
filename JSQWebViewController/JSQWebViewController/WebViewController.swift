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

    public var displaysWebViewTitle: Bool = false

    // MARK: Private properties

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
        webView.allowsBackForwardNavigationGestures = true
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

    private let activities: [UIActivity]?

    // MARK: Initialization

    public init(urlRequest: NSURLRequest, configuration: WKWebViewConfiguration = WKWebViewConfiguration(), activities: [UIActivity]? = nil) {
        self.configuration = configuration
        self.urlRequest = urlRequest
        self.activities = activities
        super.init(nibName: nil, bundle: nil)
    }

    public convenience init(url: NSURL) {
        self.init(urlRequest: NSURLRequest(URL: url))
    }

    ///  :nodoc:
    public required init(coder aDecoder: NSCoder) {
        self.configuration = WKWebViewConfiguration()
        self.urlRequest = NSURLRequest(URL: NSURL(string: "")!)
        self.activities = nil
        super.init(coder: aDecoder)
    }

    deinit {
        webView.removeObserver(self, forKeyPath: TitleKeyPath, context: nil)
        webView.removeObserver(self, forKeyPath: EstimatedProgressKeyPath, context: nil)
    }


    // MARK: View lifecycle

    ///  :nodoc:
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = urlRequest.URL?.host

        if presentingViewController?.presentedViewController != nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: Selector("didTapDoneButton:"))
        }

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: Selector("didTapActionButton:"))

        webView.loadRequest(urlRequest)
    }

    ///  :nodoc:
    public override func viewWillAppear(animated: Bool) {
        assert(navigationController != nil, "\(WebViewController.self) must be presented in a \(UINavigationController.self)")
        super.viewWillAppear(animated)
    }

    ///  :nodoc:
    public override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        webView.stopLoading()
    }

    ///  :nodoc:
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
        view.bringSubviewToFront(progressBar)
        progressBar.frame = CGRect(x: 0, y: topLayoutGuide.length, width: view.frame.size.width, height: 2)
    }


    // MARK: Actions

    internal func didTapDoneButton(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    internal func didTapActionButton(sender: UIBarButtonItem) {
        if let url = urlRequest.URL {
            let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: activities)
            activityVC.popoverPresentationController?.barButtonItem = sender
            presentViewController(activityVC, animated: true, completion: nil)
        }
    }


    // MARK: KVO

    ///  :nodoc:
    public override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>) {
        if object as? NSObject == webView {
            switch keyPath {
            case TitleKeyPath:
                if displaysWebViewTitle {
                    title = webView.title
                }

            case EstimatedProgressKeyPath:
                let completed = webView.estimatedProgress == 1.0
                progressBar.setProgress(completed ? 0.0 : Float(webView.estimatedProgress), animated: !completed)
                UIApplication.sharedApplication().networkActivityIndicatorVisible = !completed

            default: break
            }
        }
        else {
            super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
        }
    }
    
}
