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
  
  // Мы пытаемся снять обёртку и преобразовать context в экземпляр Flight. Если это удаётся, то мы используем его для задания self.flight, который в свою очередь выполняет Property observer, настраивающий интерфейс.
  override func awake(withContext context: Any?) {
    super.awake(withContext: context)
    
    if let flight = context as? Flight {
      self.flight = flight
    }
  }
  
  @IBAction func checkInButtonTapped() {
    // 1 - Мы создаём две константы: одну для длительности анимации (duration), другую — для задержки (delay), после которой контроллер будет отключен. delay — это не Double, а экземпляр DispatchTime, потому что мы будем использовать её с Grand Central Dispatch.
    let duration = 0.35
    let delay = DispatchTime.now() + (duration + 0.15)
    // 2 - Мы загружаем последовательность изображений под названием Progress и устанавливаем его в качестве фонового изображения backgroundGroup. Группы компоновки подчиняются WKImageAnimatable, что позволяет нам использовать их для воспроизведения анимированных последовательностей изображений.
    backgroundGroup.setBackgroundImageNamed("Progress")
    // 3 - Мы начинаем воспроизведение последовательности изображений. Передаваемый интервал охватывает всю последовательность, а значение repeatCount, равное 1, означает, что анимация будет воспоизводиться только один раз.
    backgroundGroup.startAnimatingWithImages(in: NSRange(location: 0, length: 10),
                                             duration: duration,
                                             repeatCount: 1)
    // 4 - В WatchKit нет обработчиков завершения, так что мы используем Grand Central Dispatch для выполнения закрытия после заданной задержки.
    DispatchQueue.main.asyncAfter(deadline: delay) { [weak self] in
    // 5 - После закрытия мы помечаем, что на рейс flight выполнена регистрация, а затем отключаем контроллер.
      self?.flight?.checkedIn = true
      self?.dismiss()
    }
  }
  
  
  
}
