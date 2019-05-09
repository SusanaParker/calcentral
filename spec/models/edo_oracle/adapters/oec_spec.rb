describe EdoOracle::Adapters::Oec do
  let(:uid) { '12345' }
  let(:term_code) { '2016-D' }
  let(:term_id) { '2168' }
  let(:course_id) { '32819' }

  before do
    allow(Settings.terms).to receive(:fake_now).and_return '2016-07-14 01:00:00'
    allow(User::BasicAttributes).to receive(:attributes_for_uids).with([uid]).and_return(
      [{
         ldap_uid: uid,
         email_address: 'kaymcnulty@arl.army.mil',
         first_name: 'Kay',
         last_name: 'McNulty'
       }])
  end

  context 'adapting course data' do
    let(:row) do
      {
        'section_id'=>'32819',
        'primary'=>'true',
        'instruction_format'=>'LEC',
        'section_num'=>'001',
        'course_display_name'=>'COMPSCI 8',
        'ldap_uid'=>uid,
        'sis_id'=>'1234567890',
        'role_code'=>'PI',
        'start_date'=>Time.parse('2016-08-24 00:00:00 UTC'),
        'end_date'=>Time.parse('2016-12-09 00:00:00 UTC'),
        'course_title_short'=>'FOUNDATION DATA SCI',
        'enrollment_count'=>22,
        'affiliations'=>'INSTRUCTOR',
        'cross_listed_ccns'=>'32819',
        'co_scheduled_ccns'=>'32819,32820,32820,32821'
      }
    end
    let(:course) { described_class.adapt_courses([row], term_code).first }

    it 'adapts course identifiers' do
      expect(course['course_cntl_num']).to eq '32819'
      expect(course['course_id']).to eq '2016-D-32819'
      expect(course['course_name']).to eq 'COMPSCI 8 LEC 001 FOUNDATION DATA SCI'
    end
    it 'de-duplicates ccn aggregates' do
      expect(course['co_scheduled_ccns']).to eq '32819,32820,32821'
    end
    it 'removes single-item ccn aggregates' do
      expect(course['cross_listed_ccns']).to be_nil
    end

    shared_examples 'role code to instructor func' do
      before { row['role_code'] = role_code }
      it { expect(course['instructor_func']).to eq instructor_func }
    end
    include_examples 'role code to instructor func' do
      let(:role_code) { 'PI' }
      let(:instructor_func) { '1' }
    end
    include_examples 'role code to instructor func' do
      let(:role_code) { 'TNIC' }
      let(:instructor_func) { '2' }
    end
    include_examples 'role code to instructor func' do
      let(:role_code) { 'ICNT' }
      let(:instructor_func) { '3' }
    end
    include_examples 'role code to instructor func' do
      let(:role_code) { 'INVT' }
      let(:instructor_func) { '4' }
    end
    include_examples 'role code to instructor func' do
      let(:role_code) { 'APRX' }
      let(:instructor_func) { '5' }
    end
    include_examples 'role code to instructor func' do
      let(:role_code) { 'FOO' }
      let(:instructor_func) { nil }
    end
    include_examples 'role code to instructor func' do
      let(:role_code) { nil }
      let(:instructor_func) { nil }
    end

    shared_examples 'affiliation-dependent data' do
      before { row['affiliations'] = affiliations }
      it { expect(course['evaluation_type']).to eq evaluation_type }
      it { expect(course['sis_id']).to eq sis_id }
    end
    include_examples 'affiliation-dependent data' do
      let(:affiliations) { 'INSTRUCTOR' }
      let(:evaluation_type) { 'F' }
      let(:sis_id) { "UID:#{uid}" }
    end
    include_examples 'affiliation-dependent data' do
      let(:affiliations) { 'STUDENT' }
      let(:evaluation_type) { 'G' }
      let(:sis_id) { '1234567890' }
    end
    include_examples 'affiliation-dependent data' do
      let(:affiliations) { 'INSTRUCTOR,STUDENT' }
      let(:evaluation_type) { 'G' }
      let(:sis_id) { '1234567890' }
    end
    include_examples 'affiliation-dependent data' do
      let(:affiliations) { nil }
      let(:evaluation_type) { nil }
      let(:sis_id) { "UID:#{uid}" }
    end

    context 'default course dates' do
      it 'removes date values' do
        expect(course).not_to include 'start_date'
        expect(course).not_to include 'end date'
      end
      it 'does not mark course as modular' do
        expect(course).not_to include 'modular course'
      end
    end
    context 'non-default course dates' do
      before { row['end_date'] = Time.parse('2016-10-09 00:00:00 UTC') }
      it 'stringifies dates' do
        expect(course['start_date']).to eq '08-24-2016'
        expect(course['end_date']).to eq '10-09-2016'
      end
      it 'marks course as modular' do
        expect(course['modular_course']).to eq 'Y'
      end
    end

    it 'fills in CalNet attributes' do
      expect(course['email_address']).to eq 'kaymcnulty@arl.army.mil'
      expect(course['first_name']).to eq 'Kay'
      expect(course['last_name']).to eq 'McNulty'
    end

    it 'leaves other values unchanged' do
      # The adapt_courses function modifies input rows directly, and so we need to preserve
      # a copy of the raw-from-the-DB values.
      orig_row = row.clone()
      %w(instruction_format section_num ldap_uid enrollment_count).each do |key|
        expect(course[key]).to eq orig_row[key]
      end
    end
  end

  context 'adapting enrollment data' do
    let(:columns) { %w(SECTION_ID LDAP_UID SIS_ID FIRST_NAME LAST_NAME EMAIL_ADDRESS) }
    let(:row) { %w(32819 12345678 87654321 Hedy Lamarr hedy@gmail.com) }

    let(:enrollment) { described_class.adapt_enrollment_row(row, columns, term_code) }

    it 'maps row index to column name' do
      expect(enrollment['SECTION_ID']).to eq '32819'
      expect(enrollment['LDAP_UID']).to eq '12345678'
      expect(enrollment['SIS_ID']).to eq '87654321'
      expect(enrollment['FIRST_NAME']).to eq 'Hedy'
      expect(enrollment['LAST_NAME']).to eq 'Lamarr'
      expect(enrollment['EMAIL_ADDRESS']).to eq 'hedy@gmail.com'
    end

    it 'derives course id' do
      expect(enrollment['COURSE_ID']).to eq '2016-D-32819'
    end

    context 'missing email address' do
      before { row[5] = nil }
      it 'fills in email address from attributes query' do
        allow(User::BasicAttributes).to receive(:attributes_for_uids).and_call_original
        expect(User::BasicAttributes).to receive(:attributes_for_uids).with(['12345678']).and_return([{
          ldap_uid: '12345678',
          email_address: 'hedy@gmail.com'
        }])
        EdoOracle::Adapters::Oec.supplement_user_attributes([row], columns)
        expect(enrollment['EMAIL_ADDRESS']).to eq 'hedy@gmail.com'
      end
    end

    context 'missing name' do
      before do
        row[3] = nil
        row[4] = nil
      end
      it 'fills in email address from attributes query' do
        allow(User::BasicAttributes).to receive(:attributes_for_uids).and_call_original
        expect(User::BasicAttributes).to receive(:attributes_for_uids).with(['12345678']).and_return([{
          ldap_uid: '12345678',
          first_name: 'Hedwig Eva Maria',
          last_name: 'Kiesler'
        }])
        EdoOracle::Adapters::Oec.supplement_user_attributes([row], columns)
        expect(enrollment['FIRST_NAME']).to eq 'Hedwig Eva Maria'
        expect(enrollment['LAST_NAME']).to eq 'Kiesler'
      end
    end
  end
end
