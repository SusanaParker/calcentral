include CalGroupsHelperModule

describe CalGroups::FindGroups do
  let(:stem_name) { 'edu:berkeley:app:bcourses' }
  let(:group_name) { 'testgroup' }
  let(:qualified_group_name) { [stem_name, group_name].join(':') }

  let(:proxy) { CalGroups::FindGroups.new(stem_name: stem_name, fake: fake) }

  let(:find_group) { proxy.find_group_by_name qualified_group_name }
  let(:name_available_response) { proxy.name_available?(group_name)[:response]  }

  after(:each) { WebMock.reset! }

  shared_examples 'group found' do
    it 'returns data for a single group' do
      expect(find_group).to have(1).item
      expect_valid_group_data(find_group.first)
    end

    it 'reports group name as unavailable' do
      expect(name_available_response).to eq false
    end
  end

  shared_examples 'group not found' do
    it 'finds nothing' do
      expect(find_group).to be_empty
    end

    it 'reports group name as available' do
      expect(name_available_response).to eq true
    end
  end

  shared_examples 'unexpected response' do
    it 'raises a properly formatted error on group query' do
      expect(name_available_response[:statusCode]).to eq 503
    end
    it 'returns an error on name query' do
      expect { || find_group }.to raise_error(Errors::ProxyError){|error| expect(error.log_message).to eq 'Error response from CalGroups'}
    end
  end

  context 'using fake data feed' do
    let(:fake) { true }

    context 'default fake group' do
      include_examples 'group found'
    end

    context 'when group does not exist' do
      before do
        proxy.override_json do |json|
          json['WsFindGroupsResults'].delete 'groupResults'
        end
      end
      include_examples 'group not found'
    end

    context 'on unsuccessful response' do
      before do
        proxy.override_json do |json|
          json['WsFindGroupsResults']['resultMetadata']['success'] = 'F'
        end
      end
      include_examples 'unexpected response'
    end
  end
end
