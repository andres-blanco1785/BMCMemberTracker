RSpec.describe Officer, type: :model do
  subject do 
    described_class.new(officer_id: "631009798", name: 'Yue Hu', email: 'yueh@tamu.edu',
                        amountOwed: 200)
  end

  it 'is valid with valid attributes' do |variable|
    
  end

end