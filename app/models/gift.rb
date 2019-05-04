class Gift < ApplicationRecord
  GIFT_TYPES = %i[n+1 target].freeze

  belongs_to :product
  has_many :line_items, dependent: :destroy

  validates :product, :gift_type, :limitation, presence: true

  validates :quantity,
            presence: true,
            numericality: { greater_than_or_equal_to: 1 },
            if: proc { gift_type.eql? 'n+1' }

  validates :amount_target,
            presence: true,
            numericality: { greater_than_or_equal_to: 150 },
            if: proc { gift_type.eql? 'target' }

  validate :date_valid?

  def type
    gift_type
  end

  def date_valid?
    errors.add(:error, 'Limitation invalid') unless limitation > Time.zone.today
  end
end
