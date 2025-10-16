
import SwiftUI

struct EventBookingMainTabView: View {
    var body: some View {
        TabView {
            EventBookingHomeScreen()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    EventBookingMainTabView()
}
