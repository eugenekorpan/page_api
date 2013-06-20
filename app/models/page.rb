class Page < ActiveRecord::Base
  attr_accessible :content, :published_on, :title, :user_id

  validates :title, :content, :user_id, presence: true

  belongs_to :user

  scope :published, where('published_on <= current_timestamp')
  scope :unpublished, where('(published_on is NULL) or (published_on > current_timestamp)')
  scope :desc, order('published_on DESC')

  def published?
    published_on && published_on <= DateTime.now
  end

  def publish!
    update_attribute(:published_on, DateTime.now)
  end

  def total_words
    title.split.size + content.split.size
  end

  def status
    published? ? 'published' : 'unpublished'
  end

  def as_json(options={})
    super.as_json(options).merge({ status: status, total_words: total_words })
  end
end
