describe CampusSolutions::PnpCalculator::CalculatorValues do
  let(:uid) { 61889 }
  let(:ugrd_sid) { 11667051 }
  let(:no_data_sid) { 123456 }
  let(:proxy) { described_class }

  describe 'fetching data from SISEDO' do
    subject { proxy.new(uid).get_feed }

    context 'as an undergraduate with data' do
      let(:pnp_calculator_values) do
        {
          "total_gpa_units" => BigDecimal.new('45.0'),
          "total_no_gpa_units" => BigDecimal.new('7.0'),
          "total_transfer_units" => BigDecimal.new('69.0'),
          "max_ratio_base_units" => BigDecimal.new('51.0'),
          "gpa_ratio_units" => BigDecimal.new('45.0'),
          "no_gpa_ratio_units" => BigDecimal.new('6.0'),
          "pnp_ratio" => BigDecimal.new('0.12'),
        }
      end
      before do
        allow(User::Identifiers).to receive(:lookup_campus_solutions_id).and_return ugrd_sid
        allow(EdoOracle::Queries).to receive(:get_pnp_calculator_values).and_return pnp_calculator_values
      end
      it 'returns the expected structure and values' do
        expect(subject[:totalGpaUnits]).to eql(45)
        expect(subject[:totalNoGpaUnits]).to eql(7)
        expect(subject[:totalTransferUnits]).to eql(69)
        expect(subject[:maxRatioBaseUnits]).to eql(51)
        expect(subject[:gpaRatioUnits]).to eql(45)
        expect(subject[:noGpaRatioUnits]).to eql(6)
        expect(subject[:pnpRatio]).to eql(0.12)
        expect(subject[:pnpPercentage]).to eql(12)
      end
    end

    context 'as a non-undergraduate with no data' do
      before { allow(User::Identifiers).to receive(:lookup_campus_solutions_id).and_return no_data_sid }
      it 'returns an empty hash' do
        expect(subject).to eql({})
      end
    end
  end
end
