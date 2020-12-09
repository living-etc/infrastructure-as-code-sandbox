RSpec.describe 'VPC' do
  describe vpc('terraform') do
    it { is_expected.to exist }
  end
end
