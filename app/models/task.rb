class Task < ApplicationRecord
  belongs_to :list

  include PgSearch
  pg_search_scope :search_by_name,
    against: [:name],
    associated_against: {
      list: [:title]
    }
end
