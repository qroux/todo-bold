require 'rails_helper'

RSpec.describe Task, type: :model do
  it 'CREATE Task' do
    User.create(email: 'test@gmail.com', password: 'azerty123')
    List.create(user_id: User.last.id)
    Task.create(name: 'my task', list_id: List.last.id)

    expect(User.count).to eq(1)
    expect(List.count).to eq(1)
    expect(Task.last.name).to eq('my task')
  end

  it 'UPDATE Task' do
    User.create(email: 'test@gmail.com', password: 'azerty123')
    List.create(user_id: User.last.id)
    Task.create(name: 'my task', list_id: List.last.id)

    expect(Task.last.name).to eq('my task')

    Task.last.update(name: 'updated task')
    expect(Task.last.name).to eq('updated task')
  end

  it 'DESTROY Task' do
    User.create(email: 'test@gmail.com', password: 'azerty123')
    List.create(user_id: User.last.id)
    Task.create(name: 'my task', list_id: List.last.id)

    expect(List.count).to eq(1)
    expect(Task.count).to eq(1)

    Task.last.destroy
    expect(Task.count).to eq(0)
  end
end
