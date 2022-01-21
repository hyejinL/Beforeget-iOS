//
//  MonthAndYearPicker.swift
//  Beforeget-iOS
//
//  Created by soyeon on 2022/01/09.
//

import UIKit

class MonthYearPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Properties
    
    var years = [Int]()
    var months = [String]()
    
    var minYear: Int = 0
    var minMonth: Int = 0
    
    var month = Calendar.current.component(.month, from: Date()) {
        didSet {
            selectRow(month - 1, inComponent: 1, animated: false)
        }
    }
    
    var year = Calendar.current.component(.year, from: Date()) {
        didSet {
            if let firstYearIndex = years.firstIndex(of: year) {
                selectRow(firstYearIndex, inComponent: 0, animated: true)
            }
        }
    }
    
    var onDateSelected: ((_ year: Int, _ month: Int) -> Void)?
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }
    
    // MARK: - Custom Method
    
    func commonSetup() {
        var years: [Int] = []
        
        if years.count == 0 {
            var year = Calendar(identifier: .gregorian).component(.year, from: Date())
            for _ in 1...2 {
                years.append(year)
                year -= 1
            }
        }
        
        self.years = years
        self.years.reverse()
        
        var months: [String] = []
        var month = 0
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM"
        for _ in 1...12 {
            months.append(dateFormatter.monthSymbols[month].localizedCapitalized)
            month += 1
        }
        
        self.months = months
        
        delegate = self
        dataSource = self
        
        let currentMonth = Calendar(identifier: .gregorian).component(.month, from: Date())
        selectRow(currentMonth - 1, inComponent: 1, animated: false)
        
        selectRow(years.count - 1, inComponent: 0, animated: true)
    }
    
    // MARK: - UIPicker Delegate / Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(years[row])"
        case 1:
            return months[row]
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return years.count
        case 1:
            return months.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let month = selectedRow(inComponent: 1) + 1
        let year = years[selectedRow(inComponent: 0)]
        
        if let block = onDateSelected {
            block(year, month)
        }
        
        self.year = year
        self.month = month
    }
}
