//
//  ViewController.swift
//  Twitter Clone
//
//  Created by Muhammad Adam on 7/2/20.
//  Copyright © 2020 MA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let jsonText = """
        {
            "show": true,
            "link": "www.google.com"
        }
        """

        // test standard Decodable instantiation
//        let jsonData = jsonText.data(using: .utf8)!
//        try? Link.init(dict: <#T##[String : Any]#>)
        
        view.backgroundColor = .red
    }


}

struct Link: Parasable{
    var show: Bool
    var link: String
}
