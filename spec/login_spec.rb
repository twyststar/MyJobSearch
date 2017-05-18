require('spec_helper')
require('pry')

describe(Login) do

  describe('#encrypt_password') do
    it("encrypt the password before saving it") do
      test_login = Login.create(:user_name => "jesse", :password =>"password")
      expect(test_login.password()).to eq("password".encrypt(:symmetric, :password => 'secret_key'))
    end
  end

  it("it validates the password before saving it") do
    test_login1 = Login.new(:user_name => "jesse", :password =>"pass")
    test_login2 = Login.new(:user_name => "jesse", :password =>"passdgnggjgkjgjggdggjknnknnlkfkfj")
    test_login3= Login.new(:user_name => "jesse", :password =>"password")
    expect(test_login1.save()).to eq(false)
    expect(test_login2.save()).to eq(false)
    expect(test_login3.save()).to eq(true)
  end

  describe('#find_user') do
    it("returns user_id based on username") do
      test_login = Login.create(:user_name => "jesse", :password =>"password")
      expect(Login.find_user("jesse")).to eq(test_login.id)
    end
  end
end
