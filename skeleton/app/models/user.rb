class User < ApplicationRecord
    validates :password, length: {minimum: 6, allow_nil: true}
    validates :username, presence: true
    validates :session_token, presence: true
    attr_reader :password

    after_initialize :ensure_session_token
    has_many :links
    has_many :comments

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)
        if user && user.is_password?(password)
            return user
        else
            return nil 
        end
    end

    def self.generate_session_token
        SecureRandom::urlsafe_base64
    end

    def reset_session_token!
        self.session_token = self.class.generate_session_token
        self.save
        self.session_token
    end

    def password=(password)
        self.password_digest = BCrypt::Password.create(password)
        @password = password
    end

    def is_password?(password)
        check_pass = BCrypt::Password.new(self.password_digest)
        check_pass.is_password?(password)
    end

    def ensure_session_token
        self.session_token ||= self.class.generate_session_token
    end
end