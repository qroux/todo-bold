require 'rails_helper'

RSpec.describe User, type: :model do
  it 'CREATE User' do
    User.create(email: 'test@gmail.com', password: 'azerty123')
    expect(User.count).to eq(1)
  end

  it 'CREATE admin User' do
    User.create(email: 'test@gmail.com', password: 'azerty123', admin: true)
    expect(User.count).to eq(1)
    expect(User.last.admin).to eq(true)
  end

  it 'UPDATE User with List association' do
    User.create(email: 'test@gmail.com', password: 'azerty123')
    List.create(title: 'procédure', user_id: User.last.id)
    User.last.update(email: 'updated@gmail.com')

    expect(User.count).to eq(1)
    expect(List.count).to eq(1)
    expect(User.last.email).to eq('updated@gmail.com')
  end

  it 'DESTROY User with List association' do
    User.create(email: 'test@gmail.com', password: 'azerty123')
    List.create(title: 'procédure', user_id: User.last.id)
    expect(User.count).to eq(1)
    expect(List.count).to eq(1)

    User.last.destroy
    expect(User.count).to eq(0)
    expect(List.count).to eq(0)
  end
end
