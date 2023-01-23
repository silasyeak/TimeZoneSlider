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
            //picker to select the first city
            Picker("Select a city", selection: $selectedCity) {
                ForEach(cities.keys.sorted(), id: \.self) { key in
                    Text(key)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            //displays the current time for the selected city
            Text("\(getTime(timeZoneOffset: cities[selectedCity]!))")
                .font(.largeTitle)
                .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                    self.selectedCity = self.selectedCity
                }
            //slider to adjust the timer offset
            HStack {
                
                Slider(value: $sliderValue, in: -12 ... 12, step: 0.1)
                TextField("", value: $sliderValue, formatter: NumberFormatter())
                    .frame(width: 50)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
            }
            
            
            //Displays the time offset for the first selected city
            Text("1st: \(getOffsetTime(sliderValue: sliderValue, timeZoneOffset: cities[selectedCity]!))")
            
            //picker to select the second city
            Picker("Select a city", selection: $selectedCity2) {
                ForEach(cities.keys.sorted(), id: \.self) { key in
                    Text(key)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            
            //Displays the current time for the selected city
            Text("\(getTime(timeZoneOffset: cities[selectedCity2]!))")
                .font(.largeTitle)
                .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                    self.selectedCity2 = self.selectedCity2
                }
            //Slider to adjust the time offset
            HStack {
                Slider(value: $sliderValue, in: -12 ... 12, step: 0.1)
                //Text field to display the current offset value
                TextField("", value: $sliderValue, formatter: NumberFormatter())
                    .frame(width: 50)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.decimalPad)
            }
            //Displays the time offset for the second selected city
            Text("2nd: \(getOffsetTime(sliderValue: sliderValue, timeZoneOffset: cities[selectedCity2]!))")
        }
    }
    //This function gets the current time for the selected city
    func getTime(timeZoneOffset: String) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: timeZoneOffset)
        formatter.dateFormat = "[MM/dd] hh:mm a"
        return formatter.string(from: date)
    }
    //offsetDate is the current time with the offset value added to it
    func getOffsetTime(sliderValue: Double, timeZoneOffset: String) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(identifier: timeZoneOffset)
        formatter.dateFormat = "[MM/dd] hh:mm a"
        let offsetDate = date.addingTimeInterval(sliderValue * 3600)
        return formatter.string(from: offsetDate)
    }
}
