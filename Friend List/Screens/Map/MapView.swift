import SwiftUI
import MapboxMaps

struct MapView: View {
    var users: [User]
    var userPressed: (User) -> Void
    
    var body: some View {
        Map {
            ForEvery(users) { user in
                MapViewAnnotation(
                    coordinate: CLLocationCoordinate2D(
                        latitude: Double(user.location.coordinates.latitude) ?? 0.0,
                        longitude: Double(user.location.coordinates.longitude) ?? 0.0
                    )
                ) {
                    Button(action: { userPressed(user) }) {
                        AsyncImage(url: URL(string: user.picture.thumbnail)) { image in
                            image
                                .resizable()
                                .frame(width: 72, height: 72)
                                .clipShape(.circle)
                        } placeholder: {
                            ProgressView()
                                .frame(width: 72, height: 72)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    MapView(users: [.mock]) { _ in }
}
