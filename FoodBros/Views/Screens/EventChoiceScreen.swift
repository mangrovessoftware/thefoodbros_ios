//
//  EventChoiceScreen.swift
//  FoodBros
//
//  Created by Muthu on 02/11/25.
//

import SwiftUI

struct EventChoiceScreen: View {
    
    @State var toShowEventBookingMainTabView: Bool = false
    
    var body: some View {
        ZStack {
            AppBackgrounds.gradientBackground
            
            VStack(spacing: 30) {
                
                AppIcons.appLogo()
                
                titleSection
                
                AppButtons.primary(type: .continueAction) {
                    
                }
            }
        }
    }
}

extension EventChoiceScreen {
    var titleSection: some View {
        Text("Choose Your Event")
            .font(.title.bold())
            .foregroundColor(Color(.primary))
    }
}

#Preview {
    EventChoiceScreen()
}


#Preview {
    EventChoiceScreen()
}
