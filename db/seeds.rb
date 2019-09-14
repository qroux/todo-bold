#admin user
User.create(email: 'quentin.roux@hotmail.fr', password: 'azerty123', admin: true)

# user 1
User.create(email: 'matmmos@gmail.com', password: 'azerty123')

List.create(title: 'Liste 1 du User 1', user_id: User.last.id, collaborators: ["#{User.last.email}"])
Task.create(name: 'a', list_id: List.last.id)
Task.create(name: 'b', list_id: List.last.id)
Task.create(name: 'c', list_id: List.last.id)

List.create(title: 'Liste 2 du User 1', user_id: User.last.id, collaborators: ["#{User.last.email}"])
Task.create(name: 'd', list_id: List.last.id)

#user 2
User.create(email: 'user2@gmail.com', password: 'azerty123')

List.create(title: 'List 1 du User 2', user_id: User.last.id, collaborators: ["#{User.last.email}"])
Task.create(name: '1', list_id: List.last.id)
Task.create(name: '2', list_id: List.last.id)
Task.create(name: '3', list_id: List.last.id)

List.create(title: 'Liste 2 du User 2', user_id: User.last.id, collaborators: ["#{User.last.email}"])
Task.create(name: '4', list_id: List.last.id)
