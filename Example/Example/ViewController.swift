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

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        let webViewController = WebViewController(url: NSURL(string: "http://jessesquires.com")!)

        switch indexPath.row {
        case 0:
            self.navigationController?.pushViewController(webViewController, animated: true)
            break
        case 1:
            break
        default: break
        }
    }

}

