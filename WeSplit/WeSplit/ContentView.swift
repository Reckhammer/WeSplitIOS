//
//  ContentView.swift
//  WeSplit
//
//  Created by Joshua Rechkemmer on 1/25/24.
//  CSCI 4335-001 Lee
//  Spring 2024
//

import SwiftUI

struct ContentView: View 
{
    @State private var checkAmt = 0.0;
    @State private var numPeople = 2;
    @State private var tipPercent = 20;
    let tipPercentages = [10, 15, 20, 25, 0];
    
    var totalPerPerson: Double
    {
        let peopleCount = Double(numPeople);
        let total = grandTotal;
        let amtPerPerson = total / peopleCount;
        
        return amtPerPerson;
    }
    
    var grandTotal: Double
    {
        let tipSelection = Double(tipPercent);
        
        let tipVal = checkAmt / 100 * tipSelection;
        let total = checkAmt + tipVal;
        
        return total;
    }
    
    @FocusState private var amtIsFocused: Bool
    
    var body: some View 
    {
        NavigationStack 
        {
            Form 
            {
                Section("Check Amount")
                {
                    TextField("Amount", value: $checkAmt, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                    }.focused($amtIsFocused);
                    
                Section("How much tip do you want to leave?")
                {
                    Picker("Tip Percentage", selection: $tipPercent)
                    {
                            ForEach(tipPercentages, id: \.self) {
                                Text($0, format: .percent);
                            }
                        }
                        .pickerStyle(.segmented);
                    }
                    
                    //Picker("Number of people", selection: $numPeople) {
                    //    ForEach(2..<100) {
                    //        Text("\($0) people");
                    //    }
                    //}
                    //.pickerStyle(.navigationLink);
                    
                Section("Number of People")
                {
                    TextField("Number of People", value: $numPeople, format: .number)
                        .keyboardType(.numberPad)
                        .focused($amtIsFocused);
                }
                Section("Total")
                {
                    Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"));
                        
                }
                    
                Section("Amount Per Person")
                {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"));
                        
                }
            }
                .navigationTitle("WeSplit")
                .toolbar {
                    if (amtIsFocused) {
                        Button("Done") {
                            amtIsFocused = false;
                        }
                    }
                }
            }
            
        }
        
    }

#Preview {
    ContentView()
}
