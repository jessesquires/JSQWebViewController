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

import JSQWebViewController


class ViewController: UITableViewController {

    let url = NSURL(string: "http://jessesquires.com")!

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        switch indexPath.row {
        case 0:
            let webViewController = WebViewController(url: url)
            navigationController?.pushViewController(webViewController, animated: true)

        case 1:
            let webViewController = WebViewController(url: url)
            let nav = UINavigationController(rootViewController: webViewController)
            presentViewController(nav, animated: true, completion: nil)

        default: break
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let webViewController = segue.destinationViewController as? WebViewController
        webViewController?.urlRequest = NSURLRequest(URL: url)
    }
    
}

