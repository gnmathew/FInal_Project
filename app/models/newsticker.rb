class Newsticker < ApplicationRecord

  belongs_to :admin, class_name: 'Newsticker', optional: true

  enum status: {active: 0, inactive: 1}

end
