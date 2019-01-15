//
//  ViewController.swift
//  OS_Logger
//
//  Created by Marco Parolin on 15/01/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK:- Variables
    private var username: String = "username"
    private var password: String = "password"

    // MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        logger("This is a generic log")
        logger("This is also a generic log, but this should be private", shouldBePrivate: true)
    }

    // MARK:- IBActions
    @IBAction func logInfoAction(_ sender: Any) {
        logger("Device name: \(UIDevice.current.name)", .general, .debug)
    }
    
    @IBAction func logWarningAction(_ sender: Any) {
        logger("This is a warning", .network, .warning)
    }
    
    @IBAction func logErrorAction(_ sender: Any) {
        logger("This is an error", .network, .error)
    }
    
    @IBAction func logProtectedAction(_ sender: Any) {
        logger("Login credentials: { usr: \(username), pwd: \(password) }", .auth)
    }
    
}

