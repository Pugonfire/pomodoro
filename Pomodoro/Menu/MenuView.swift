//
//  MenuView.swift
//  pomodoro
//
//  Created by Max Z on 30/11/21.
//

import SwiftUI

struct MenuView: View {
    // Slide animation
    @Namespace var animation
    // Current tab
    @State var currentTab = "Uploads"
    var body: some View {
        VStack{
            HStack{
                TabButton(title: "Help", currentTab: $currentTab, animation: animation)
                TabButton(title: "Uploads", currentTab: $currentTab, animation: animation)
            }
            .padding(.horizontal)
            .padding(.top)
            
            Divider()
                .padding(.top, 2)
            
            Image("bb_sloth")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(30)
            
            Spacer(minLength: 15)
            Divider()
                .padding(.top, 2)
        
            HStack{
                
                Image("pengy")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                
                Text("Pomodoro")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)
                
                Spacer(minLength: 0)
                
                Button(action: {}, label: {
                    Image(systemName: "gearshape.fill")
                        .foregroundColor(.primary)
                })
                    .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
            .padding(.bottom)
        }
        // sizing
        .frame(width: 250, height: 300)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}

struct TabButton: View {
    var title: String
    @Binding var currentTab: String
    var animation: Namespace.ID
    
    var body: some View {
        Button(action:{}, label: {
            Text(title)
                .font(.callout)
                .fontWeight(.bold)
                // Dark mode adoption
                .foregroundColor(currentTab == title ? .white : .primary)
                .frame(maxWidth: .infinity)
                .background(
                    ZStack{
                        if currentTab == title {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.blue)
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        } else {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.primary)
                        }
                    }
                )
            })
            .buttonStyle(PlainButtonStyle())
    }
}
