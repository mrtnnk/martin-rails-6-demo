class Credential < ApplicationRecord
  validates :external_id, :public_key, presence: true
end
