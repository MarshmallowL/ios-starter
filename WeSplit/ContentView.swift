//
//  ContentView.swift
//  WeSplit
//
//  Created by 刘光曙 on 2022/2/8.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmout = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = [10,15,20,25,0]
    @FocusState private var amountIsFocused: Bool
    let currencyCode: FloatingPointFormatStyle<Double>.Currency = .currency(code: "CNY")
    
    //使用计算属性获取最后的结果值
    var totalPerPerson:Double{
        let peopleCount = Double(numberOfPeople + 2)
        let grandTotal = totalAmout
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var totalAmout: Double{
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmout / 100 * tipSelection
        let grandTotal = checkAmout + tipValue
        return grandTotal
    }
    
    var body: some View {
        NavigationView{
            Form{
                Section{
                    //TextField 只允许输入string,可以对其进行转换
                    //.keyboardType 设置输入时弹出的键盘类型 使用模拟器时需要CMD + K 快捷键弹出键盘
                    TextField("Amount:",value: $checkAmout,format:currencyCode)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    //选择器 需要添加navigationView才能在新页面中选择
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2 ..< 100){
                            Text("\($0) people")
                        }
                    }
                }
                
                Section{
                    //pickerStyle 可设置选择器的样式
                    Picker("Tip percentage",selection: $tipPercentage){
                        ForEach(0 ..< 101){percent in
                            Text(percent,format: .percent)
                        }
                    }.pickerStyle(.automatic)
                }header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section{
                    Text(totalPerPerson,format:currencyCode)
                }header: {
                    Text("Amount Per Person")
                }
                
                Section{
                    Text(totalAmout,format: .currency(code: Locale.current.currencyCode ?? "USD"))
                }header: {
                    Text("Total Amount")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                ToolbarItemGroup(placement: .keyboard){
                    Spacer()
                    
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            ContentView()
        }
    }
}
