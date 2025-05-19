//
//  ContentView.swift
//  TempConvert
//
//  Created by Dhruva Jothik Byrapatna on 5/19/25.
//

import SwiftUI

struct ContentView: View {
    enum tempUnit: String, CaseIterable, Identifiable{
        case F, C, K
        var id: String { self.rawValue }
            
        var label: String {
            switch self {
            case .F: return "°F"
            case .C: return "°C"
            case .K: return "°K"
            }
        }
    }
    @State private var inputTempUnit: tempUnit = .F
    @State private var outputTempUnit: tempUnit = .C
    @State private var inputTemp: Double = 32.0
    
    @FocusState private var inputIsFocused:Bool
    func converter(inputTemp:Double, inUnit:tempUnit, outUnit: tempUnit) -> Double{
        //convert to C then out to final
        var celsiusTemp = 0.0
        if(inUnit==tempUnit.C){
            celsiusTemp = inputTemp
        } else if(inUnit==tempUnit.F){
            celsiusTemp  = (inputTemp-32)*5.0/9.0
        } else{
            celsiusTemp = inputTemp-273.15
        }
        
        if(outUnit==tempUnit.C){
            return celsiusTemp
        }else if(outUnit==tempUnit.F){
            return (celsiusTemp * 9.0 / 5.0) + 32.0
        }
        return celsiusTemp+273.15
        
    }
    
    
    let tempUnits = ["F", "C", "K"]
    var outputInF: Double {
        let currInputTempUnit = inputTempUnit
        let currOutputTempUnit = tempUnit.F
        let currInputTemp = inputTemp
        return converter(inputTemp: currInputTemp, inUnit: currInputTempUnit, outUnit: currOutputTempUnit)
    }
    var outputInC: Double {
        let currInputTempUnit = inputTempUnit
        let currOutputTempUnit = tempUnit.C
        let currInputTemp = inputTemp
        return converter(inputTemp: currInputTemp, inUnit: currInputTempUnit, outUnit: currOutputTempUnit)
    }
    var outputInK: Double {
        let currInputTempUnit = inputTempUnit
        let currOutputTempUnit = tempUnit.K
        let currInputTemp = inputTemp
        return converter(inputTemp: currInputTemp, inUnit: currInputTempUnit, outUnit: currOutputTempUnit)
    }
    
    
    var outputTemp: Double{
        if outputTempUnit == tempUnit.F{
            return outputInF
        } else if outputTempUnit == tempUnit.C{
            return outputInC
        }
        return outputInK
    }
    
    
    var body: some View {
        NavigationStack{
            Form{
                Section ("Input Temperature Below"){
                    TextField("Input Temperature", value:$inputTemp, format:  .number.precision(.fractionLength(2)))
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
       
                }
                Section("Input Temp Unit"){
                    Picker("Input Temperature Unit", selection:$inputTempUnit){
                        ForEach(tempUnit.allCases){
                            unit in Text(unit.label).tag(unit)

                        }
                    }.pickerStyle(.segmented)
                }
                Section("Output Temp Unit"){
                    
                    
                    Picker("Output Temperature Unit", selection:$outputTempUnit){
                        ForEach(tempUnit.allCases){
                            unit in Text(unit.label).tag(unit)

                        }
                    }.pickerStyle(.segmented)
                }
                
                Section ("Converted Temperature"){
                    Text(outputTemp, format:  .number.precision(.fractionLength(2)))
                    
                }
           
                
            }
        }
        .navigationTitle("TempConvert")
        .toolbar {
            if inputIsFocused {
                Button("Done") {
                    inputIsFocused = false
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
