//
//  ScheduleInterfaceController.swift
//  Watch Extension
//
//  Created by Stepan Vasiljeu on 2/14/19.
//  Copyright © 2019 Mic Pringle. All rights reserved.
//

import WatchKit
import Foundation


class ScheduleInterfaceController: WKInterfaceController {

  @IBOutlet weak var flightsTable: WKInterfaceTable!
  
  var flights = Flight.allFlights()
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    flightsTable.setNumberOfRows(flights.count, withRowType: "FlightRow")
    
    
    // Здесь мы проходим в цикле for по каждой строке в таблице и запрашиваем у таблицы контроллер строк с соответствующим индексом. Если мы правильно запрашиваем контроллер, то получаем экземпляр FlightRowController. Затем мы задаём controller.flight соответствующий элемент flight в массиве flights. Это приводит к выполнению наблюдателя didSet в FlightRowController и настраивает все метки в строке таблицы.
    for index in 0..<flightsTable.numberOfRows {
      guard let controller = flightsTable.rowController(at: index) as? FlightRowController else { continue }
      
      controller.flight = flights[index]
    }
  }

  // Здесь мы получаем из flights соответствующий рейс, используя индекс строки, переданный в этот метод. Затем мы отображаем интерфейс сведений о рейсе, в качестве context передавая flight. Помните, что имя, передаваемое в presentController(withName:context:) — это идентификатор, заданный нами в storyboard в предыдущей части туториала.
  override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
    let flight = flights[rowIndex]
    presentController(withName: "Flight", context: flight)
  }
  
  
  
}
