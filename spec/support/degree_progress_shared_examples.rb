shared_examples 'a proxy that returns graduate milestone data' do

  it 'returns data with the expected structure' do
    expect(subject[:feed][:degreeProgress]).to be
    expect(subject[:feed][:degreeProgress].first[:acadCareer]).to be
    expect(subject[:feed][:degreeProgress].first[:acadPlan]).to be
    expect(subject[:feed][:degreeProgress].first[:acadProgCode]).to be
    expect(subject[:feed][:degreeProgress].first[:acadProg]).to be
    expect(subject[:feed][:degreeProgress].first[:requirements]).to be
  end

  it 'filters out any LAW career programs that are not LACAD' do
    expect(subject[:feed][:degreeProgress].length).to eql(5)
  end

  it 'filters out requirements that we don\'t want to display' do
    expect(subject[:feed][:degreeProgress][0][:requirements].length).to eql(2)
    expect(subject[:feed][:degreeProgress][1][:requirements].length).to eql(2)
  end

  it 'replaces codes with descriptive names' do
    expect(subject[:feed][:degreeProgress][0][:requirements][0][:name]).to eql('Advancement to Candidacy (Thesis Plan)')
    expect(subject[:feed][:degreeProgress][0][:requirements][0][:status]).to eql('Not Satisfied')
    expect(subject[:feed][:degreeProgress][1][:requirements][1][:name]).to eql('Advancement to Candidacy (Capstone Plan)')
    expect(subject[:feed][:degreeProgress][1][:requirements][1][:status]).to eql('Not Satisfied')
    expect(subject[:feed][:degreeProgress][2][:requirements][0][:name]).to eql('Approval for Qualifying Exam')
    expect(subject[:feed][:degreeProgress][2][:requirements][0][:status]).to eql('Approved')
    expect(subject[:feed][:degreeProgress][2][:requirements][2][:name]).to eql('Advancement to Candidacy')
    expect(subject[:feed][:degreeProgress][2][:requirements][2][:status]).to eql('Completed')
  end

  it 'marks a milestone \'Not Satisfied\' if it has an unexpected status code' do
    expect(subject[:feed][:degreeProgress][0][:requirements][1][:status]).to eql('Not Satisfied')
  end

  it 'formats dates' do
    expect(subject[:feed][:degreeProgress][0][:requirements][0][:dateCompleted]).to eq ''
    expect(subject[:feed][:degreeProgress][1][:requirements][0][:dateCompleted]).to eq ''
    expect(subject[:feed][:degreeProgress][2][:requirements][0][:dateCompleted]).to eq 'Dec 22, 2016'
  end

  it 'attaches a notification if the milestone is incomplete and requires a form' do
    expect(subject[:feed][:degreeProgress][0][:requirements][0][:formNotification]).to eql('(Form Required)')
    expect(subject[:feed][:degreeProgress][1][:requirements][0][:formNotification]).to eql('(Form Required)')
    expect(subject[:feed][:degreeProgress][1][:requirements][1][:formNotification]).to be nil
    expect(subject[:feed][:degreeProgress][2][:requirements][0][:formNotification]).to be nil
  end

  it 'contains the expected Qualifying Exam milestone attempts data ordered with most recent first' do
    qualifying_exam_attempts = subject[:feed][:degreeProgress][2][:requirements][1][:attempts]
    expect(qualifying_exam_attempts.count).to eq 2
    expect(qualifying_exam_attempts[0][:sequenceNumber]).to eq 2
    expect(qualifying_exam_attempts[0][:statusCode]).to eq 'P'
    expect(qualifying_exam_attempts[1][:sequenceNumber]).to eq 1
    expect(qualifying_exam_attempts[1][:statusCode]).to eq 'F'
  end

  it 'builds a string to represent the milestone attempt' do
    qualifying_exam_attempts = subject[:feed][:degreeProgress][2][:requirements][1][:attempts]
    expect(qualifying_exam_attempts[0][:display]).to eq 'Exam 2: Passed Dec 22, 2016'
    expect(qualifying_exam_attempts[1][:display]).to eq 'Exam 1: Failed Oct 01, 2016'
  end

  context 'when the QE Results milestone is not satisfied' do
    context 'when the exam hasn\'t been attempted' do
      it 'includes the proposed exam date on the QE Approval milestone' do
        qualifying_exam_approval_milestone = subject[:feed][:degreeProgress][4][:requirements][0]
        expect(qualifying_exam_approval_milestone[:proposedExamDate]).to eq 'Feb 14, 2017'
      end
    end
    context 'when the exam has been attempted' do
      it 'does not include the proposed exam date on the QE Approval milestone' do
        qualifying_exam_approval_milestone = subject[:feed][:degreeProgress][3][:requirements][0]
        expect(qualifying_exam_approval_milestone[:proposedExamDate]).to be nil
      end
    end
    it 'does not include the proposed exam date on other milestones' do
      other_milestone = subject[:feed][:degreeProgress][0][:requirements][0]
      expect(other_milestone[:proposedExamDate]).not_to be
    end
  end
end
