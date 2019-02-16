//
//  FlightRowController.swift
//  Watch Extension
//
//  Created by Stepan Vasiljeu on 2/15/19.
//  Copyright © 2019 Mic Pringle. All rights reserved.
//

import WatchKit

class FlightRowController: NSObject {

  @IBOutlet var separator: WKInterfaceSeparator!
  @IBOutlet var originLabel: WKInterfaceLabel!
  @IBOutlet var destinationLabel: WKInterfaceLabel!
  @IBOutlet var flightNumberLabel: WKInterfaceLabel!
  @IBOutlet var statusLabel: WKInterfaceLabel!
  @IBOutlet var planeImage: WKInterfaceImage!
  
  // 1 - Мы объявляем вспомогательное свойство типа Flight. Помните, что этот класс объявляется в Flight.swift, который является частью общего кода, добавляенного к Watch Extension в предыдущей части туториала.
  var flight: Flight? {
    // 2 - Добавляем Property observer, выполняемый при задании свойства.
    didSet {
      // 3 - Выполняем выход, если flight имеет значение nil: это необязательный шаг, но мы хотим продолжать настройку меток только если у нас есть правильный экземпляр Flight.
      guard let flight = flight else { return }
      // 4 - Настраиваем метки с помощью соответствующих свойств flight.
      originLabel.setText(flight.origin)
      destinationLabel.setText(flight.destination)
      flightNumberLabel.setText(flight.number)
      // 5 - Если рейс откладывается, то мы меняем цвет текста метки на красный и соответствующим образом обновляем текст.
      if flight.onSchedule {
        statusLabel.setText("On Time")
      } else {
        statusLabel.setText("Delayed")
        statusLabel.setTextColor(.red)
      }
    }
  }
  
  // Здесь мы создаём экземпляр UIColor, затем используем его для задания цвета оттенка и цвета соответственно planeImage и separator. Этот метод будет вызываться при закрытии анимации, поэтому смена цвета будет красиво анимирована.
  func updateForCheckIn() {
    let color = UIColor(red: 90/255, green: 200/255, blue: 250/255, alpha: 1)
    planeImage.setTintColor(color)
    separator.setColor(color)
  }
  
}
