class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # devise :invitable, :database_authenticatable, :registerable, :confirmable,
  #        :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  has_many :comments

  attr_accessor :terms
  attr_accessor :privacy_policy
  validates_acceptance_of :terms, :allow_nil => false, :message => :terms_not_accepted, :on => :create
  validates_acceptance_of :privacy_policy, :allow_nil => false, :message => :terms_not_accepted, :on => :create

  # validates_acceptance_of :tos_agreement, :allow_nil => false, :accept => true, :on => :create
end
