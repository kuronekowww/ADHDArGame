//
//  TabBar.swift
//  AR ADHD
//
//  Created by  王佳鸣 on 2022/5/9.
//

import SwiftUI

struct TabBar: View {
    @AppStorage("selectedtab") var selectedTab: Tab = .main
    var body: some View {
        ZStack(alignment: .bottom) {
            HStack {
                ForEach(tabItems){ item in
                    Button{
                        withAnimation(.spring(response: 0.2, dampingFraction: 0.7)){
                        selectedTab = item.tab
                        }
                    } label: {
                    VStack(spacing:4) {
                        Image(systemName: item.icon)
                            .font(.title2)
                            .frame(width:50, height:25)
                        Text(item.text)
                            .font(.footnote)
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                }
                    .foregroundStyle(selectedTab == item.tab ? .primary : .secondary)
                    .symbolVariant(selectedTab == item.tab ? .fill : .none)
                    .foregroundColor(selectedTab == item.tab ? .accentColor : .secondary)
                }
            }
            .padding(.horizontal,8)
            .padding(.top, 16)
            .frame(height: 88, alignment: .top)
            .background(.regularMaterial,in:RoundedRectangle(cornerRadius: 20,style:.continuous))
            .background(
                HStack{
                    if selectedTab == .profile { Spacer() }
                    if selectedTab == .game { Spacer() }
                    Circle().fill(.white.opacity(0.3)).frame(width: 140)
                    if selectedTab == .main { Spacer()}
                    if selectedTab == .game { Spacer() }
                }
            )
            .strokeStyles(cornerRadius: 20)
            .frame(maxHeight: .infinity, alignment: .bottom)
            .ignoresSafeArea()
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar()
    }
}
