//
//  CheckInInterfaceController.swift
//  Watch Extension
//
//  Created by Stepan Vasiljeu on 2/16/19.
//  Copyright © 2019 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation


class CheckInInterfaceController: WKInterfaceController {

  @IBOutlet var backgroundGroup: WKInterfaceGroup!
  @IBOutlet var originLabel: WKInterfaceLabel!
  @IBOutlet var destinationLabel: WKInterfaceLabel!

  // Здесь мы добавили вспомогательное свойство типа Flight, которое включает в себя Property observer. При выполнении наблюдателя он пытается снять обёртку с flight, и если это удаётся, использует flight для настройки двух меток. Всё это уже нам знакомо.
  var flight: Flight? {
    didSet {
      guard let flight = flight else { return }
      
      originLabel.setText(flight.origin)
      destinationLabel.setText(flight.destination)
    }
  }
  
}
