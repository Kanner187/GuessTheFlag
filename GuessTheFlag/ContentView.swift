//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Levit Kanner on 28/10/2019.
//  Copyright © 2019 Levit Kanner. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    //Properties
   @State private var countries = ["Estonia" , "Nigeria" , "France" , "UK" , "Germany" , "Ireland" , "Italy" , "Poland" , "Russia" , "Spain" , "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var alertMessage = ""
    @State private var animationAmount = 0.0
    
    
    
    // Body initialization
    var body: some View {
        NavigationView{
            ZStack{
                 LinearGradient(gradient: Gradient(colors: [.blue , .black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                     .edgesIgnoringSafeArea(.all)
                 VStack(spacing: 30){
                     
                     VStack{
                         Text("Tap the flag of")
                         .foregroundColor(.white)
                         
                         Text(countries[correctAnswer])
                             .foregroundColor(.white)
                             .font(.largeTitle)
                             .fontWeight(.black)
                          }
                            
                    ForEach(0..<3){number in
                     Button(action: {
                         //Flag tapped implementation
                        self.flagTapped(number){
                            self.alertMessage = $0
                        }
            
                     }){
                     Image(self.countries[number])
                         .renderingMode(.original)
                         }
                     }
                 .clipShape(Capsule())     //Puts the buttons in a capsule shape
                 .overlay(Capsule().stroke(Color.black , lineWidth: 1))      //Add capsule styled border around flags
                 .shadow(color: .black, radius: 2, x: 2, y: 2)
                 .rotation3DEffect(.degrees(self.animationAmount), axis: (x: 0, y: 1, z: 0))
                
                    
                    
                    //Alert
                 .alert(isPresented: $showingScore) {
                    Alert(title: Text(scoreTitle), message: Text("\(self.alertMessage)"), dismissButton: .default(Text("Continue")){
                         self.askQuestion()
                         })
                     }
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.headline)
                 Spacer()
                    
                 }
             }
        }
    }
    
    
    //Methods
    func flagTapped(_ number: Int , message : (String)-> Void){
        if number == correctAnswer {
            withAnimation {
                self.animationAmount += 360
                scoreTitle = "That's Correct"
                score += 1
                message("You're a genius!")
            }
            
        }else{
            scoreTitle = "Wrong"
            message("That's the flag of \(self.countries[number])")
        }
        showingScore = true
    }
    
    
    func askQuestion(){
        countries = countries.shuffled()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





/*
 What I've learnt today in SwiftUI
1. Vstacks , Hstacks , ZStack , Spacers(To divide views)
2. Colors and frames
3. Secondary(Allows slight transparency for the color behind it to shine through it) and Primary colors in SwiftUI
4. You can create custom colors : Color(red: , green: , blue: ) and pass numbers between 0 and 1.
5. EdgesIgnoringSafeArea() to run over the safe area bounds.
6. Gradients : LinearGradient , RadialGradient , AngularGradient; They can be used as stand-alone views or as background of views
7. Buttons
8.Images with decorative(Prevents screen-readers from reading Image titles) , systemName , nothing
9. Adding renderingMode modifier to images to show their original images
10.Alerts
 */
