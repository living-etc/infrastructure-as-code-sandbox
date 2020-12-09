iac_tool = ENV['IAC_TOOL']

RSpec.describe 'VPC' do
  describe vpc(iac_tool) do
    it { is_expected.to exist }
  end

  [
    "#{iac_tool}-private-eu-west-1a",
    "#{iac_tool}-private-eu-west-1b",
    "#{iac_tool}-private-eu-west-1c",
  ].each do |private_availability_zone|
    describe route_table(private_availability_zone) do
      it { is_expected.to have_route('10.0.0.0/16').target(gateway: 'local') }
      it { is_expected.to have_subnet(private_availability_zone) }
      it { is_expected.to_not have_route('0.0.0.0/0') }
    end
  end

  describe route_table("#{iac_tool}-public") do
    it { is_expected.to have_route('10.0.0.0/16').target(gateway: 'local') }
    it { is_expected.to have_route('0.0.0.0/0').target(gateway: iac_tool) }
  end

  describe internet_gateway(iac_tool) do
    it { is_expected.to exist }
    it { is_expected.to be_attached_to(iac_tool) }
  end
end
