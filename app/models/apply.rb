class Apply < ApplicationRecord
    enum status: {pending: 0, accepted: 1, rejected:2}
    belongs_to :job
    belongs_to :user
end
