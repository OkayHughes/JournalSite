class Entry < ActiveRecord::Base
    searchable do 
        text :title, :boost => 5
        text :authors, :boost => 3
        text :abstract
    end
end
