class Task < ApplicationRecord
  enum status: [:todo, :doing, :done]

  validates :name, presence: true
  validates :detail, presence: true
  validate :validate_due_date

  # 今より昔の日付時刻は終了期限に設定できない
  def validate_due_date
    if due_date.present? && due_date < DateTime.now
      errors.add(:due_date, I18n.t('errors.datetime'))
    end
  end
end
