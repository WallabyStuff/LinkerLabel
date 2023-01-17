//
//  ViewController.swift
//  LinkerLabel
//
//  Created by Wallaby on 01/15/2023.
//  Copyright (c) 2023 Wallaby. All rights reserved.
//

import UIKit
import LinkerLabel

class ViewController: UIViewController {
  
  // MARK: - UI
  
  @IBOutlet weak var linkerLabel: LinkerLabel!
  
  
  // MARK: - LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  
  // MARK: - Setups
  
  private func setup() {
    setupView()
  }
  
  private func setupView() {
    setupLinkerLabel()
  }
  
  private func setupLinkerLabel() {
    linkerLabel.delegate = self
    linkerLabel.decorateLink(.email)
  }
}


// MARK: - Delegate

extension ViewController: LinkerLabelDelegate {
  func didTapLink(_ text: String) {
    print(text)
  }
}
