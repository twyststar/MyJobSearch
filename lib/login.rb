class Login < ActiveRecord::Base
  validates(:password, {:presence => true, :length => { in: 5..20}})
  after_save(:encrypt_password)

  def self.find_user(user_name)
    logins = Login.all()
    matching_user_id = 0
    logins.each do |login|
      if login.user_name.downcase == user_name.downcase
        matching_user_id = login.id
      end
    end
    matching_user_id
  end

private

    def encrypt_password
      self.password=(password().encrypt(:symmetric, :password => 'secret_key'))
    end
end
