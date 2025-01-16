import SwiftUI

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int

    var body: some View {
        HStack(spacing: 4) {
            ForEach(1..<6) { star in
                Image(systemName: star <= rating ? "star.fill" : "star")
                    .font(.system(size: 30))
                    .foregroundColor(.yellow)
                    .onTapGesture {
                        self.rating = star
                    }
                    
            }
        }
    }
}

struct ContentView2: View {
    @State private var userRating = 0

    var body: some View {
        VStack {
            Text("Rate this app:")
            RatingView(rating: $userRating)
            Text("You rated \(userRating) stars.")
        }
        .padding()
    }
}

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}
