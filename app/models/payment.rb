class Payment < ApplicationRecord
	# not specifying primary key searches by default id which is the record num (1, 2, ...)
	# specify keys to X_id connects by UIN which is more intuitive to use
	#belongs_to :member # this leaves finding member to default id which is record num ie 1
    #belongs_to :officer # this leaves finding member to default id which is record num ie 1
	belongs_to :member, :foreign_key => 'member_id', :primary_key => 'member_id'
	belongs_to :officer, :foreign_key => 'officer_id',  :primary_key => 'officer_id'
end
