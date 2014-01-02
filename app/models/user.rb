class User < ActiveRecord::Base
  extend FriendlyId

  has_many :albums, :dependent => :destroy

  friendly_id :username, use: :slugged
  validates :username, presence: true
  validates :email, presence: true
  validates :location, presence: true
  has_attached_file :photo, :styles => { :small => "150x150>" }
  acts_as_followable
  acts_as_follower

  #validates_attachment_presence :photo
  validates_attachment_size :photo, :less_than => 5.megabytes
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image.png']

  

  def self.from_omniauth(auth)
  	where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
  		user.provider = auth.provider
  		user.uid = auth.uid
  		user.username = auth.info.name
  		user.location = auth.info.location
  		user.email = auth.info.email
  		user.slug = auth.info.name.parameterize
  		user.oauth_token = auth.credentials.token
  		user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user1 = FbGraph::User.fetch(auth.info.name.split[0], :access_token => auth.credentials.token)
      albums = user1.albums
  		user.save(:validate => false)
  	end
  end

  #def should_generate_new_friendly_id?
  #  new_record?
  #end
  
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def self.search(search)
  if search
    find(:all, :conditions => ['username LIKE ?', "%#{search}%"])
  else
    find(:all)
  end
end

end
