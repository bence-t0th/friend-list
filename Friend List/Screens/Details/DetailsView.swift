import SwiftUI

struct DetailsView: View {
    @Environment(\.openURL) private var openURL
    
    let user: User
    
    @State private var contentHeight: CGFloat = .zero
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: user.picture.thumbnail)) { image in
                image
                    .resizable()
                    .frame(width: 72, height: 72)
                    .clipShape(.circle)
            } placeholder: {
                ProgressView()
                    .frame(width: 72, height: 72)
            }
            .padding(.top, 36)
            
            Text(user.name.first.appending(" ").appending(user.name.last))
                .font(.title)
            
            Text(user.login.username)
                .font(.subheadline)
                .foregroundStyle(.gray)
            
            HStack(alignment: .top, spacing: 16) {
                Image("balloon")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.accent)
                VStack(alignment: .leading) {
                    Text("\(user.gender), \(user.dob.age)")
                    
                    Text(user.dob.date.formatted(date: .abbreviated, time: .omitted))
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }
            .padding(16)
            .background(Color.gray.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding(.horizontal)
            
            HStack(alignment: .top, spacing: 16) {
                Image("pin")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundStyle(.accent)
                
                VStack(alignment: .leading) {
                    Text("\(user.location.postcode.description), \(user.location.state)")
                    Text("\(user.location.city), \(user.location.street.name)")
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
            }
            .padding(16)
            .background(Color.gray.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding(.horizontal)
            
            VStack {
                HStack(spacing: 16) {
                    Image("phone")
                        .resizable()
                        .frame(width: 20,height: 20)
                        .foregroundStyle(.accent)
                    Text(user.phone)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                
                HStack(spacing: 16) {
                    Image("mail")
                        .resizable()
                        .frame(width: 20,height: 20)
                        .foregroundStyle(.accent)
                    Text(user.email)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .onTapGesture {
                    openURL(URL(string: "mailto:\(user.email)")!)
                }
            }
            .padding(16)
            .background(Color.gray.opacity(0.4))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .padding(.horizontal)

            (
                Text("Registered on ") +
                Text(
                    user.registered.date,
                    format: .dateTime
                        .year()
                        .month()
                        .day()
                        .hour()
                        .minute()
                        .timeZone()
                    )
            )
            .font(.caption)
            .foregroundStyle(.gray)
            .padding(.top)
        }
        .background(
            GeometryReader { geo in
                Color.clear
                    .onAppear {
                        contentHeight = geo.size.height
                    }
            }
        )
        .presentationDragIndicator(.visible)
        .presentationDetents([.height(contentHeight)])
    }
}

#Preview {
    @State @Previewable var user: User? = .mock
    Button(action: { user = .mock }) {
        Text("Show details")
    }
    .sheet(item: $user) { user in
        DetailsView(user: user)
    }
}
