//
//  FlightInterfaceController.swift
//  AirAber
//
//  Created by Stepan Vasiljeu on 2/8/19.
//  Copyright © 2019 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation


class FlightInterfaceController: WKInterfaceController {

  @IBOutlet var flightLabel: WKInterfaceLabel!
  @IBOutlet var routeLabel: WKInterfaceLabel!
  @IBOutlet var boardingLabel: WKInterfaceLabel!
  @IBOutlet var boardTimeLabel: WKInterfaceLabel!
  @IBOutlet var statusLabel: WKInterfaceLabel!
  @IBOutlet var gateLabel: WKInterfaceLabel!
  @IBOutlet var seatLabel: WKInterfaceLabel!
  
  // 1 - Мы объявили вспомогательное свойство типа Flight. Этот класс объявляется в Flight.swift, который является частью общего кода, ранее добавленного в целевую конфигурацию Watch Extension.
  var flight: Flight? {
    // 2 - Мы добавили Property observer, выполняемый при задании свойства.
    didSet {
      // 3 - Мы проверяем, что во вспомогательном свойстве содержится действительно рейс, а не nil. Мы можем продолжать конфигурировать метки только если знаем, что у нас есть верный экземпляр Flight.
      guard let flight = flight else { return }
      // 4 - Мы конфигурируем метки с помощью соответствующих свойств flight.
      flightLabel.setText("Flight \(flight.shortNumber)")
      routeLabel.setText(flight.route)
      boardingLabel.setText("\(flight.number) Boards")
      boardTimeLabel.setText(flight.boardsAt)
      // 5 - Если рейс откладывается, то мы меняем цвет текста в метке на красный.
      if flight.onSchedule {
        statusLabel.setText("On Time")
      } else {
        statusLabel.setText("Delayed")
        statusLabel.setTextColor(.red)
      }
      gateLabel.setText("Gate \(flight.gate)")
      seatLabel.setText("Seat \(flight.seat)")
    }
  }
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    flight = Flight.allFlights().first
  }
  
}
