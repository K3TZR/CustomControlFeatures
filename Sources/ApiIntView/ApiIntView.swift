//
//  ApiIntView.swift
//  ViewFeatures/ApiIntView
//
//  Created by Douglas Adams on 2/19/23.
//

import SwiftUI

public struct ApiIntView: View {
  let hint: String
  let value: Int
  let formatter: NumberFormatter
  let action: (String) -> Void
  let isValid: (String) -> Bool
  let width: CGFloat
  let font: Font
  
  public init
  (
    hint: String = "",
    value: Int,
    formatter: NumberFormatter = NumberFormatter(),
    action: @escaping (String) -> Void,
    isValid: @escaping (String) -> Bool = { _ in true },
    width: CGFloat = 100,
    font: Font = .body
  )
  {
    self.hint = hint
    self.value = value
    self.formatter = formatter
    self.action = action
    self.isValid = isValid
    self.width = width
    self.font = font
  }
  
  @State var valueString = ""
  @State var entryMode = false
  
  @FocusState private var entryFocus: Bool

  public var body: some View {
    if entryMode {
      // Editable view
      TextField(hint, text: $valueString)
        .focusable()
        .focused($entryFocus)
        .font(font)
        .multilineTextAlignment(.trailing)
        .frame(width: width)
      
        .onAppear {
          // force focus & selection
          self.entryFocus = true
        }
      
        .onChange(of: valueString) { newValue in
          // validate as each digit is enterred
          if !isValid(newValue) {
            valueString = String(valueString.dropLast(1))
            NSSound.beep()
          }
        }
      
        .onExitCommand {
          // abort (ESC key)
          entryMode = false
        }
      
        .onSubmit {
          // submit (ENTER key)
          action(valueString)
          entryMode = false
        }
      
    } else {
      // Fixed view
      Text(formatter.string(from: value as NSNumber)!)
        .font(font)
        .multilineTextAlignment(.trailing)
        .frame(width: width)
        .zIndex(1)
      
        .onTapGesture {
          // switch to Editable view
          valueString = NumberFormatter().string(from: value as NSNumber)!
          entryMode = true
        }
    }
  }
}

struct ApiIntView_Previews: PreviewProvider {
  static var previews: some View {
    
    var formatter: NumberFormatter {
      let formatter = NumberFormatter()
      formatter.groupingSeparator = "."
      formatter.numberStyle = .decimal
      return formatter
    }
    
    Group {
      ApiIntView(hint: "frequency", value: 14_200_000, formatter: formatter, action: { print("value = \($0)") }, isValid: {_ in true }, width: 140, font: .title3 )
      
      ApiIntView(value: 600, action: { print("value = \($0)") } )
      
    }.frame(width: 200, height: 50)
  }
}