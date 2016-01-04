class Submission < ActiveRecord::Base
    validates :title, presence: true
    validates :authors, presence: true
    validates :doi, presence: true
    validates :abstract, presence: true
    validates :journal, presence: true
end
