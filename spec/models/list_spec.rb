require 'rails_helper'

RSpec.describe List, type: :model do
  it 'CREATE List with default title' do
    User.create(email: 'test@gmail.com', password: 'azerty123')
    List.create(user_id: User.last.id)

    expect(List.count).to eq(1)
    expect(List.last.title).to eq('Nouvelle Liste')
  end

  it 'UPDATE List' do
    User.create(email: 'test@gmail.com', password: 'azerty123')
    List.create(user_id: User.last.id)

    expect(List.count).to eq(1)
    expect(List.last.title).to eq('Nouvelle Liste')

    List.last.update(title: 'updated title')
    expect(List.count).to eq(1)
    expect(List.last.title).to eq('updated title')
  end

  it 'DESTROY List' do
    User.create(email: 'test@gmail.com', password: 'azerty123')
    List.create(user_id: User.last.id)

    expect(List.count).to eq(1)
    expect(List.last.title).to eq('Nouvelle Liste')

    List.last.destroy
    expect(List.count).to eq(0)
  end
end
