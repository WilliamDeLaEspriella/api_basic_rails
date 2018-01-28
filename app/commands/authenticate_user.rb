class AuthenticateUser 
	
	prepend SimpleCommand 
	
	def initialize(email, password) 
		@email = email 
		@password = password 
	end 
	
	def call 
		encode(email: user.email) if user 
	end 
	
	private 
	
	attr_accessor :email, :password 
	def encode(payload, exp = 24.hours.from_now) 
		payload[:exp] = exp.to_i 
		JWT.encode(payload, Rails.application.secrets.secret_key_base) 
	end 
	def user

		user = User.find_by_email(email) 
		return user if user && user.authenticate(password) 
		
		errors.add :user_authentication, 'invalid credentials' 
		
		nil 
	end 
end
