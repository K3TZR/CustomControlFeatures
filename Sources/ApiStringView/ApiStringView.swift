//
//  ApiStringView.swift
//  ViewFeatures/ApiStringView
//
//  Created by Douglas Adams on 2/19/23.
//

import SwiftUI

public struct ApiStringView: View {
  let hint: String
  let value: String
  let action: (String) -> Void
  let isValid: (String) -> Bool
  let width: CGFloat
  let font: Font
  
  public init
  (
    hint: String = "",
    value: String,
    action: @escaping (String) -> Void,
    isValid: @escaping (String) -> Bool = { _ in true },
    width: CGFloat = 100,
    font: Font = .body
  )
  {
    self.hint = hint
    self.value = value
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
      Text(value)
        .font(font)
        .frame(width: width, alignment: .leading)
      
        .onTapGesture {
          // switch to Editable view
          valueString = value
          entryMode = true
        }
    }
  }
}

struct ApiStringView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      ApiStringView(hint: "name", value: "Doug's Flex", action: { print("value = \($0)") }, isValid: {_ in true }, width: 140, font: .title3 )
      
      ApiStringView(value: "K3TZR", action: { print("value = \($0)") } )
      
    }.frame(width: 200, height: 50)
  }
}
