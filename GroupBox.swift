GroupBox {
    Text("Your account")
        .font(.headline)
    Text("Username: tswift89")
    Text("City: Nashville")
}
// you can use VStack either

GroupBox {
    Text("Outer Content")

    GroupBox {
        Text("Middle Content")

        GroupBox {
            Text("Inner Content")
        }
    }
}
