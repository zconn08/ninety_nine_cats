class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :name, uniqueness: true
  validate :correct_sex, :correct_color

  def age
    Time.now.strftime("%Y").to_i - birth_date.strftime("%Y").to_i
  end

  private
  def correct_sex
    unless ["M", "F"].include?(sex)
      errors[:sex] << "needs to be M or F"
    end
  end
  def correct_color
    unless ["black", "brown", "white", "red", "grey", "orange"].include?(color)
      errors[:color] << "needs to be a valid color"
    end
  end
end
