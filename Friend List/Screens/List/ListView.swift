import SwiftUI

struct ListView: View {
    var users: [User]
    var userPressed: ((User) -> Void)
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(users, id: \.id.hashValue) { user in
                        cell(user: user)
                    }
                }
                .padding([.top, .horizontal], 16)
                .padding(.bottom, 100)
            }
            .navigationTitle("My Friends")
        }
    }
    
    private func cell(user: User) -> some View {
        Button(action: {
            userPressed(user)
        }) {
            HStack(spacing: 16) {
                AsyncImage(url: URL(string: user.picture.thumbnail)) { image in
                    image
                        .resizable()
                        .frame(width: 54, height: 54)
                        .clipShape(.circle)
                } placeholder: {
                    ProgressView()
                }
                VStack {
                    Text(user.name.first.appending(" ").appending(user.name.last))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text(user.login.username)
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .buttonStyle(.plain)
    }
}
