//
//  ContentView.swift
//  TimeZoneSlider
//
//  Created by Silas Yeak on 1/12/23.
//



/*
 import SwiftUI
 
 struct ContentView: View {
 @State private var selectedTimeZone = TimeZone.current.identifier
 
 var body: some View {
 VStack {
 Picker("Select a time zone", selection: $selectedTimeZone) {
 ForEach(TimeZone.knownTimeZoneIdentifiers, id: \.self) { timeZone in
 Text(TimeZone(identifier: timeZone)?.localizedName(for: .standard, locale: Locale.current) ?? "")
 }
 }
 Text("\(getTime(timeZone: selectedTimeZone))")
 .font(.largeTitle)
 .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
 self.selectedTimeZone = self.selectedTimeZone
 }
 
 
 }
 }
 func getTime(timeZone: String) -> String {
 let date = Date()
 let formatter = DateFormatter()
 formatter.timeZone = TimeZone(identifier: timeZone)
 formatter.dateFormat = "HH:mm:ss"
 return formatter.string(from: date)
 }
 }
 */





import SwiftUI

struct ContentView: View {
    @State private var sliderValue = 0.0
    
    @State private var selectedCity = "EST"
    @State private var selectedCity2 = "Guam"
    let cities = ["PST": "PST", "EST": "EST", "Singapore": "Asia/Singapore", "Guam": "Pacific/Guam"]
    let timeZones = TimeZone.knownTimeZoneIdentifiers
    //let is a constant and var is a variable
    
    var body: some View {
        VStack {
            Picker("Select a city", selection: $selectedCity) {
                ForEach(cities.keys.sorted(), id: \.self) { key in
                    Text(key)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Text("\(getTime(timeZoneOffset: cities[selectedCity]!))")
                .font(.largeTitle)
                .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                    self.selectedCity = self.selectedCity
                }
            //Slider(value: $sliderValue, in: -12 ... 12, step: 0.1)
            HStack {
                
                Slider(value: $sliderValue, in: -12 ... 12, step: 0.1)
                TextField("", value: $sliderValue, formatter: NumberFormatter())
                    .frame(width: 50)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
            }
            
            
            //I think just have the slider add to the hours then just + whatever value, maybe make it constant
            Text("1st: \(getOffsetTime(sliderValue: sliderValue, timeZoneOffset: cities[selectedCity]!))")
            
            
            Picker("Select a city", selection: $selectedCity2) {
                ForEach(cities.keys.sorted(), id: \.self) { key in
                    Text(key)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Text("\(getTime(timeZoneOffset: cities[selectedCity2]!))")
                .font(.largeTitle)
                .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                    self.selectedCity2 = self.selectedCity2
                }
            HStack {
                
                Slider(value: $sliderValue, in: -12 ... 12, step: 0.1)
                TextField("", value: $sliderValue, formatter: NumberFormatter())
                    .frame(width: 50)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
            }
            Text("2nd: \(getOffsetTime(sliderValue: sliderValue, timeZoneOffset: cities[selectedCity2]!))")
        }
    }
    func getTime(timeZoneOffset: String) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: timeZoneOffset)
        formatter.dateFormat = "[MM/dd] hh:mm a"
        return formatter.string(from: date)
    }
    //figure this out later
    func getOffsetTime(sliderValue: Double, timeZoneOffset: String) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: timeZoneOffset)
        formatter.dateFormat = "[MM/dd] hh:mm a"
        let offsetDate = date.addingTimeInterval(sliderValue * 3600)
        return formatter.string(from: offsetDate)
    }
    
    
    
    
    
    
    
    
    
}

/*
 
 import SwiftUI
 
 struct ContentView: View {
 @State private var sliderValue = 0.0
 @State private var selectedCity = "New York"
 let cities = ["New York": "America/New_York", "Paris": "Europe/Paris", "Tokyo": "Asia/Tokyo", "Sydney": "Australia/Sydney"]
 
 //let cities = ["PST": "PST", "EST": "EST", "Singapore": "Asia/Singapore", "Guam": "Pacific/Guam"]
 @State private var selectedTimeZone = TimeZone.knownTimeZoneIdentifiers
 
 var body: some View {
 VStack {
 
 
 Picker("Select a city", selection: $selectedCity) {
 ForEach(cities.keys.sorted(), id: \.self) { key in
 Text(key)
 }
 }
 .pickerStyle(SegmentedPickerStyle())
 /*
  Picker("Select a time zone", selection: $selectedTimeZone) {
  //figure out a sorting & searching method for this
  ForEach(TimeZone.knownTimeZoneIdentifiers, id: \.self) { timeZone in
  Text(TimeZone(identifier: timeZone)?.localizedName(for: .standard, locale: Locale.current) ?? "")
  }
  }
  */
 
 Text("\(getTime(timeZone: selectedTimeZone, offsetValue: sliderValue))")
 .font(.largeTitle)
 .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
 self.selectedTimeZone = self.selectedTimeZone
 }
 /*
  Picker("Select a time zone", selection: $selectedTimeZone2) {
  ForEach(TimeZone.knownTimeZoneIdentifiers, id: \.self) { timeZone in
  Text(TimeZone(identifier: timeZone)?.localizedName(for: .standard, locale: Locale.current) ?? "")
  }
  }
  */
 Slider(value: $sliderValue, in: -12 ... 12, step: 0.1)
 
 Text("\(getTime(timeZone: selectedTimeZone, offsetValue : sliderValue))")
 
 
 
 }
 
 }
 
 func getTime(timeZone: String, offsetValue : Double) -> String {
 let date = Date()
 let formatter = DateFormatter()
 formatter.timeZone = TimeZone(identifier: timeZone)
 formatter.dateFormat = "HH:mm:ss"
 let offset = String(format: "%.1f", offsetValue) // format the offset value as a double with 1 decimal place
 return formatter.string(from: date) + " (\(offsetValue >= 0 ? "+" : "")\(offset))"
 }
 
 
 
 
 }
 */

