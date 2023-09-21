class SellRequest < ApplicationRecord

  belongs_to :appointment
  has_many :sell_details, dependent: :destroy

  validates :option_a, :option_b, :option_c, presence: true
  validate :after_today

  private

  def after_today
    [:option_a, :option_b, :option_c].each do |option|
      return if option.blank?
      errors.add(option, "は今日以降のものを選択してください") if send(option) < Date.today
    end
  end

end
