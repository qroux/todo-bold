#admin user
User.create(email: 'quentin.roux@hotmail.fr', password: 'azerty123', admin: true)

# user 1
User.create(email: 'matmmos@gmail.com', password: 'azerty123')

List.create(title: 'rendez vous', user_id: User.last.id)
Task.create(name: 'a', list_id: List.last.id)
Task.create(name: 'b', list_id: List.last.id)
Task.create(name: 'c', list_id: List.last.id)

List.create(title: 'procédure', user_id: User.last.id)
Task.create(name: 'd', list_id: List.last.id)

List.create(user_id: User.last.id)

#user 2
User.create(email: 'user2@gmail.com', password: 'azerty123')

List.create(title: 'ma liste', user_id: User.last.id)
Task.create(name: '1', list_id: List.last.id)
Task.create(name: '2', list_id: List.last.id)
Task.create(name: '3', list_id: List.last.id)

List.create(title: 'autre liste', user_id: User.last.id)
Task.create(name: '4', list_id: List.last.id)
