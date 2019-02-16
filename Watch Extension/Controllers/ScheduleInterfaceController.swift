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
  var selectedIndex = 0 // Мы используем его для того, чтобы запомнить, какая строка таблицы выбрана при отображении двух контроллеров интерфейса. Теперь достаточно задать его при выборе строки таблицы.
  
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    flightsTable.setNumberOfRows(flights.count, withRowType: "FlightRow")
    
    
    // Здесь мы проходим в цикле for по каждой строке в таблице и запрашиваем у таблицы контроллер строк с соответствующим индексом. Если мы правильно запрашиваем контроллер, то получаем экземпляр FlightRowController. Затем мы задаём controller.flight соответствующий элемент flight в массиве flights. Это приводит к выполнению наблюдателя didSet в FlightRowController и настраивает все метки в строке таблицы.
    for index in 0..<flightsTable.numberOfRows {
      guard let controller = flightsTable.rowController(at: index) as? FlightRowController else { continue }
      
      controller.flight = flights[index]
    }
  }

  override func didAppear() {
    super.didAppear()
    // 1 - Проверяем, выполнена ли регистрация на выбранный рейс. Если это так, то мы пытаемся преобразовать контроллер строки с соответствующим индексом в таблице в экземпляр FlightRowController.
    guard flights[selectedIndex].checkedIn,
      let controller = flightsTable.rowController(at: selectedIndex) as? FlightRowController else {
        return
    }
    // 2 - Если это удаётся, то используем API анимации на WKInterfaceController для выполнения закрытия через 0,35 секунды.
    animate(withDuration: 0.35) {
      // 3 - При закрытии мы вызываем метод, только что добавленный в FlightRowController, который изменяет цвет изображения и разделителя в этой строке таблицы, и обеспечивает пользователям наглядную обратную связь, сообщающую о том, что регистрация выполнена.
      controller.updateForCheckIn()
    }
  }
  
  // Здесь мы получаем соответствующий рейс из flights с индексом rowIndex, создаём массив, содержащий идентификаторы двух контроллеров интерфейса, которые мы хотим отобразить, а затем отобразить их, передав обоим flight в качестве context.
  override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
    let flight = flights[rowIndex]
    let controllers = ["Flight", "CheckIn"]
    selectedIndex = rowIndex // Эта строка задаёт selectedIndex значение индекса выбранной строки таблицы.
    presentController(withNames: controllers, contexts: [flight, flight])
  }
  
  
  
}
