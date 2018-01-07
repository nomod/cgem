class Chat::Operator < ApplicationRecord

  belongs_to :user

  before_save :create_email

  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i, message: 'неккоректный формат'

  #проверка уникальности email в базе с учетом регистра
  validates_uniqueness_of :email, case_sensitive: false

  validates_length_of :password, minimum: 6, message: 'Минимальная длина 6 символов'

  #создание виртуальных полей и проверка на наличие и совпадения password и password_confirmation
  # + шифрует для записи в базу User.password_digest с использованием gem 'bcrypt'
  has_secure_password


  private

  #сохраняем в базу поле Operator.email в нижнем регистре
  def create_email
    self.email = email.downcase
  end

end