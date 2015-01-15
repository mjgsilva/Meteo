//
//  ViewController.swift
//  Meteo
//
//  Created by Mário Silva on 12/12/14.
//  Copyright (c) 2014 Mário Silva. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

