class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  validate :validate_due_date

  def validate_due_date
    return unless due_date.present?
    errors.add(
      :due_date,
      (I18n.t('errors.datetime') if (DateTime.parse(due_date) rescue ArgumentError) == ArgumentError)
    )
  end
end
