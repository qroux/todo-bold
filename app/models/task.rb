class Task < ApplicationRecord
  belongs_to :list

  include PgSearch
  pg_search_scope :kinda_spelled_like,
    against: :name,
    associated_against: {
      list: :title
    }
end
