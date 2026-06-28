import Foundation

extension User {
    static let mock: User = User(
        gender: "male",
        name: Name(
            title: "Mr",
            first: "Emre",
            last: "Grov"
        ),
        location: Location(
            street: Street(
                number: 7590,
                name: "Gina Krogs vei"
            ),
            city: "Brunstad",
            state: "Oppland",
            country: "Norway",
            postcode: .string("3084"),
            coordinates: Coordinates(
                latitude: "46.7130",
                longitude: "-33.0789"
            ),
            timezone: Timezone(
                offset: "-2:00",
                description: "Mid-Atlantic"
            )
        ),
        email: "emre.grov@example.com",
        login: Login(
            uuid: "446c419c-5f0f-475c-89c9-718dd6492f5c",
            username: "silvermeercat493",
            password: "mission",
            salt: "w9a0DwWs",
            md5: "e804eb17b88f28442dceef154b1a5f37",
            sha1: "c6d6dce009c145c445882af21f708a403d836bd3",
            sha256: "cc7a7fad9f7b5de60e6c7722135a98bbb7ba6b17bd57b5c065be137602b28213"
        ),
        dob: DateInfo(
            date: .now,
            age: 76
        ),
        registered: DateInfo(
            date: .now,
            age: 13
        ),
        phone: "83251937",
        cell: "48533957",
        id: ID(
            name: "FN",
            value: "17015021985"
        ),
        picture: Picture(
            large: "https://randomuser.me/api/portraits/men/84.jpg",
            medium: "https://randomuser.me/api/portraits/med/men/84.jpg",
            thumbnail: "https://randomuser.me/api/portraits/thumb/men/84.jpg"
        ),
        nat: "NO"
    )
}
