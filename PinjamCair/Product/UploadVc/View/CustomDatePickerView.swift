//
//  CustomDatePickerView.swift
//  PinjamCair
//
//  Created by Ryan Thomas on 2026/2/24.
//

import UIKit
import SnapKit

class CustomDatePickerView: UIView {
    
    var onConfirm: ((String) -> Void)?
    
    private let containerView = UIView()
    private let titleLabel = UILabel()
    
    private let headerStack = UIStackView()
    private let dayHeaderLabel = UILabel()
    private let monthHeaderLabel = UILabel()
    private let yearHeaderLabel = UILabel()
    
    private let pickerView = UIPickerView()
    private let confirmButton = UIButton(type: .system)
    
    private var days: [String] = []
    private var months: [String] = []
    private var years: [String] = []
    
    private var selectedDay = "01"
    private var selectedMonth = "01"
    private var selectedYear = "1990"
    
    private let monthDays = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    
    init(initialDate: String? = nil) {
        super.init(frame: .zero)
        setupData()
        setupUI()
        parseInitialDate(initialDate)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupData() {
        months = (1...12).map { String(format: "%02d", $0) }
        years = (1950...2050).map { String($0) }
        updateDaysForCurrentSelection()
    }
    
    // 根据选中的年月更新天数
    private func updateDaysForCurrentSelection() {
        guard let year = Int(selectedYear),
              let month = Int(selectedMonth) else { return }
        
        let maxDay = getMaxDaysForMonth(month: month, year: year)
        days = (1...maxDay).map { String(format: "%02d", $0) }
        
        if let currentDay = Int(selectedDay), currentDay > maxDay {
            selectedDay = String(format: "%02d", maxDay)
        }
        
        pickerView.reloadComponent(0)
        
        if let dayIndex = days.firstIndex(of: selectedDay) {
            pickerView.selectRow(dayIndex, inComponent: 0, animated: true)
        }
    }
    
    private func getMaxDaysForMonth(month: Int, year: Int) -> Int {
        if month == 2 && isLeapYear(year: year) {
            return 29
        }
        return monthDays[month - 1]
    }
    
    private func isLeapYear(year: Int) -> Bool {
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
    }
    
    private func setupUI() {
        
        backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        addSubview(containerView)
        containerView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        containerView.layer.cornerRadius = 20
        
        containerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(420)
        }
        
        // Title
        titleLabel.text = LocalStr("Select date")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textAlignment = .left
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        // MARK: - Header Stack (Day / Month / Year)
        headerStack.axis = .horizontal
        headerStack.distribution = .fillEqually
        headerStack.alignment = .center
        
        containerView.addSubview(headerStack)
        headerStack.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(2)
            make.height.equalTo(24)
        }
        
        [dayHeaderLabel, monthHeaderLabel, yearHeaderLabel].forEach {
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            $0.textColor = .darkGray
            headerStack.addArrangedSubview($0)
        }
        
        dayHeaderLabel.text = LocalStr("Day")
        monthHeaderLabel.text = LocalStr("Month")
        yearHeaderLabel.text = LocalStr("Year")
        
        // MARK: - Picker
        pickerView.delegate = self
        pickerView.dataSource = self
        
        containerView.addSubview(pickerView)
        pickerView.snp.makeConstraints { make in
            make.top.equalTo(headerStack.snp.bottom).offset(8)
            make.left.right.equalToSuperview()
            make.height.equalTo(220)
        }
        
        // MARK: - Confirm Button
        confirmButton.setTitle(LocalStr("Confirm"), for: .normal)
        confirmButton.backgroundColor = UIColor.systemGreen
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.layer.cornerRadius = 25
        confirmButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        confirmButton.addTarget(self, action: #selector(confirmTapped), for: .touchUpInside)
        
        containerView.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-40)
            make.height.equalTo(50)
        }
    }
    
    // MARK: - Parse Date
    private func parseInitialDate(_ dateString: String?) {
        guard let dateString = dateString else {
            selectDefault()
            return
        }
        
        let components = dateString.split(separator: "/")
        
        if components.count == 3 {
            let day = String(components[0])
            let month = String(components[1])
            let year = String(components[2])
            
            if months.contains(month), years.contains(year) {
                selectedMonth = month
                selectedYear = year
                
                updateDaysForCurrentSelection()
                
                if days.contains(day) {
                    selectedDay = day
                } else {
                    selectedDay = days.last ?? "01"
                }
                
                // 设置选中的行
                if let dayIndex = days.firstIndex(of: selectedDay) {
                    pickerView.selectRow(dayIndex, inComponent: 0, animated: false)
                }
                if let monthIndex = months.firstIndex(of: month) {
                    pickerView.selectRow(monthIndex, inComponent: 1, animated: false)
                }
                if let yearIndex = years.firstIndex(of: year) {
                    pickerView.selectRow(yearIndex, inComponent: 2, animated: false)
                }
                
                return
            }
        }
        
        selectDefault()
    }
    
    private func selectDefault() {
        selectedDay = "01"
        selectedMonth = "01"
        selectedYear = "1990"
        
        updateDaysForCurrentSelection()
        
        pickerView.selectRow(0, inComponent: 0, animated: false)
        pickerView.selectRow(0, inComponent: 1, animated: false)
        if let index = years.firstIndex(of: "1990") {
            pickerView.selectRow(index, inComponent: 2, animated: false)
        }
    }
    
    // MARK: - Action
    @objc private func confirmTapped() {
        let result = "\(selectedDay)/\(selectedMonth)/\(selectedYear)"
        onConfirm?(result)
        self.removeFromSuperview()
    }
}

// MARK: - UIPickerView Delegate
extension CustomDatePickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return days.count
        case 1: return months.count
        case 2: return years.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.width / 3
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    rowHeightForComponent component: Int) -> CGFloat {
        return 48.pix()
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    viewForRow row: Int,
                    forComponent component: Int,
                    reusing view: UIView?) -> UIView {
        
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textColor = .black
        
        switch component {
        case 0: label.text = days[row]
        case 1: label.text = months[row]
        case 2: label.text = years[row]
        default: break
        }
        
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    didSelectRow row: Int,
                    inComponent component: Int) {
        
        switch component {
        case 0:
            selectedDay = days[row]
            
        case 1:
            selectedMonth = months[row]
            updateDaysForCurrentSelection()
            
        case 2:
            selectedYear = years[row]
            updateDaysForCurrentSelection()
            
        default: break
        }
    }
}
