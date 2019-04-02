//
//  ViewController.swift
//  AppStoreNavigation
//
//  Created by Kouki Saito on 2019/04/02.
//  Copyright © 2019 Kouki Saito. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "number \(indexPath.row)"
        return cell
    }

}


class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    let headerHeight: CGFloat = 212

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        print("viewDidAppear")
        scrollViewDidScroll(tableView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = headerHeight - view.safeAreaInsets.top

        let alpha = min(scrollView.contentOffset.y, offset) / offset
        print(headerHeight)
        print(navigationController?.navigationBar.frame.height)
        print(view.safeAreaInsets.top)

        print(alpha)
        if alpha >= 1.0 {
            let image = UIImage.colorImage(color: UIColor.white.withAlphaComponent(alpha))
            navigationController?.navigationBar.shadowImage = nil
            navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        } else {
            let image = UIImage.colorImage(color: UIColor.white.withAlphaComponent(alpha))
            navigationController?.navigationBar.shadowImage = UIImage()
            navigationController?.navigationBar.setBackgroundImage(image, for: .default)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "number \(indexPath.row)"
        return cell
    }
}

extension UIImage {
    class func colorImage(color: UIColor) -> UIImage {
        let size = CGSize(width: 1, height: 1)
        UIGraphicsBeginImageContext(size)
        let rect = CGRect(origin: CGPoint.zero, size: size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
