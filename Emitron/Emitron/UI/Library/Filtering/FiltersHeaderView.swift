/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

private enum Layout {
  struct Padding {
    let overall: CGFloat = 12
    let textTrailing: CGFloat = 2
  }
  
  static let padding = Padding()
  static let cornerRadius: CGFloat = 9
  static let imageSize: CGFloat = 15
}

struct FiltersHeaderView: View {
  var filterGroup: FilterGroup
  @EnvironmentObject var filters: Filters
  
  @State var isExpanded: Bool = false
  
  var body: some View {
    VStack {
      HStack {
        Text(filterGroup.type.name)
          .foregroundColor(.appBlack)
          .font(.uiLabel)
          .padding([.trailing], Layout.padding.textTrailing)
        
        Spacer()
        
        Button(action: {
          self.isExpanded.toggle()
        }) {
          Text(isExpanded ? "Hide" : "Show")
            .foregroundColor(.battleshipGrey)
            .font(.uiLabel)
        }
      }
      .padding(.all, Layout.padding.overall)
        .background(Color.white)
        .cornerRadius(Layout.cornerRadius)
        .shadow(color: Color.black.opacity(0.05), radius: 1, x: 0, y: 2)
        .frame(minHeight: 50)
      
      if isExpanded {
        expandedView()
      }
    }
  }
  
  func expandedView() -> AnyView {
    return AnyView(
      VStack(alignment: .leading, spacing: 12) {
        
        ForEach(Array(filterGroup.filters), id: \.self) { filter in
          FilterView(filter: filter)
        }
      })
  }
}

#if DEBUG
struct FilterGroupView_Previews: PreviewProvider {
  static var previews: some View {
    return FiltersHeaderView(filterGroup: FilterGroup(type: .categories))
  }
}
#endif