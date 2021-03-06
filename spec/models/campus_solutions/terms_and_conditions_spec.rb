describe CampusSolutions::TermsAndConditions do
  let(:user_id) { '12345' }

  context 'post' do
    let(:params) { {} }
    let(:proxy) { CampusSolutions::TermsAndConditions.new(fake: true, user_id: user_id, params: params) }
    let(:aid_years_response) {
      {
        aidYears: [
          {
            id: 2016,
            termsAndConditions: {
              approved: terms_and_conditions_approved
            }
          }, {
            id:2015,
            termsAndConditions: {
              approved: terms_and_conditions_approved
            }
          }
        ]
      }
    }
    let(:terms_and_conditions_approved) { nil }

    before do
      allow_any_instance_of(FinancialAid::MyAidYears).to receive(:get_feed).and_return aid_years_response
    end

    context 'filtering out fields not on the whitelist' do
      let(:params) { {
        bogus: 1,
        invalid: 2,
        response: 'N'
      } }
      subject { proxy.filter_updateable_params(params) }
      it 'should strip out invalid fields' do
        expect(subject.keys.length).to eq 2
        expect(subject[:bogus]).to be_nil
        expect(subject[:invalid]).to be_nil
        expect(subject[:response]).to be
      end
    end

    context 'converting params to Campus Solutions field names' do
      let(:params) { {
        response: 'Y'
      } }
      subject {
        result = proxy.construct_cs_post(params)
        MultiXml.parse(result)['Terms_Conditions']
      }
      it 'should convert the CalCentral params to Campus Solutions params without exploding on bogus fields' do
        expect(subject['UC_RESPONSE']).to eq 'Y'
        expect(subject['INSTITUTION']).to eq 'UCB01'
      end
    end

    context 'performing a post with an invalid aid year' do
      let(:params) { {
        response: 'Y',
        aidYear: '2018'
      } }
      subject {
        proxy.post
      }
      it 'raises an error and aborts' do
        expect{
          subject
        }.to raise_error Errors::BadRequestError, /Invalid request: {:response=>"Y", :aidYear=>"2018"}/
        expect(CampusSolutions::Proxy).to receive(:get).never
      end
    end

    context 'performing a post with a permitted aid year' do
      let(:params) { {
        response: 'Y',
        aidYear: '2016'
      } }
      subject {
        proxy.post
      }
      it_should_behave_like 'a simple proxy that returns errors'
      it_behaves_like 'a proxy that properly observes the financial_aid feature flag'
      it_behaves_like 'a proxy that got data successfully'

      context 'when response has already been recorded for this aid year' do
        let(:terms_and_conditions_approved) { false }
        it 'raises an error and aborts' do
          expect{
            subject
          }.to raise_error Errors::BadRequestError, /Invalid request: {:response=>"Y", :aidYear=>"2016"}/
          expect(CampusSolutions::Proxy).to receive(:get).never
        end
      end
    end
  end
end
