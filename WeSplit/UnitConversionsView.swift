//
//  UnitConversionsView.swift
//  WeSplit
//
//  Created by 刘光曙 on 2022/2/14.
//

import SwiftUI

struct UnitConversionsView: View {
    let timeUnit = ["seconds","minutes","hours","days"]
    @State private var inputUnit = "seconds"
    @State private var outputUnit = "seconds"
    @State private var inputValue = 0.0
    @FocusState private var inputIsFocus: Bool
    
    var outputValue:Double{
        var seconds = 0.0
        switch inputUnit{
        case "seconds": seconds = inputValue
        case "minutes": seconds = inputValue * 60
        case "hours": seconds = inputValue * 60 * 60
        case "days": seconds = inputValue * 60 * 60 * 24
        default:
            seconds = 0.0
        }
        switch outputUnit{
        case "seconds": return seconds
        case "minutes": return seconds/60
        case "hours": return seconds/(60*60)
        case"days":return seconds/(60*60*24)
        default:
            return seconds;
        }
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section{
                    TextField("输入时间",value: $inputValue,format: .number)
                        .keyboardType(.numberPad)
                        .focused($inputIsFocus)
                }header: {
                    Text("输入时间")
                }
                Section {
                    Picker("输入时间单位",selection:$inputUnit){
                        ForEach(timeUnit,id:\.self){
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented )
                }header: {
                    Text("输入时间单位")
                }
                Section {
                    Picker("输出时间单位",selection:$outputUnit){
                        ForEach(timeUnit,id:\.self){
                            Text("\($0)")
                        }
                    }.pickerStyle(.segmented )
                }header: {
                    Text("输出时间单位")
                }
                Section{
                    Text("\(inputValue,specifier: "%g") \(inputUnit) = \(outputValue,specifier: "%g") \(outputUnit)")
                }header: {
                    Text("转换结果")
                }
            }
            .navigationTitle("Time conversion")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()

                    Button("Done"){
                        inputIsFocus = false
                    }
                }
            }
        }
        
    }
}

struct UnitConversionsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            UnitConversionsView()
        }
    }
}

