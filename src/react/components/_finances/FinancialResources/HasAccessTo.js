import PropTypes from 'prop-types';
import { connect } from 'react-redux';
import { activeRoles } from '../../../helpers/roles';
import getLink from './getLink';

const propTypes = {
  dispatch: PropTypes.func.isRequired,
  linkName: PropTypes.string,
  links: PropTypes.object,
  myAcademics: PropTypes.object,
  myStatus: PropTypes.object,
};

const hasAccessToLink = (key, roles, careers, programs, delegate, summer) => {
  const linkAccess = {
    activateFPP: {
      roles: ['student'],
      excludedPrograms: ['GSSDP', 'LSSDPL'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    bearsFinancialSuccess: {
      roles: ['student', 'applicant', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    berkeleyInternationalOffice: {
      roles: ['student', 'applicant', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    billingFAQ: {
      roles: ['student', 'applicant', 'exStudent'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    calStudentCentral: {
      roles: ['student', 'applicant', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    debitAccount: {
      roles: ['student', 'applicant', 'exStudent'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    costOfAttendance: {
      roles: ['student', 'applicant', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    delegateAccess: {
      roles: ['student'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: false,
      allowsSummerVisitor: false,
    },
    directDeposit: {
      roles: ['student'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    directDepositEnroll: {
      roles: ['student'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: false,
      allowsSummerVisitor: false,
    },
    directDepositManage: {
      roles: ['student'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: false,
      allowsSummerVisitor: false,
    },
    dreamActApplication: {
      roles: ['student', 'applicant', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    emergencyLoan: {
      roles: ['student'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: false,
      allowsSummerVisitor: false,
    },
    emergencyLoanApply: {
      roles: ['student'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: false,
      allowsSummerVisitor: false,
    },
    fafsa: {
      roles: ['student', 'applicant', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    fafsaVerify: {
      roles: ['student', 'applicant', 'staff', 'faculty', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    federalStudentLoans: {
      roles: ['student', 'applicant', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    finaidForms: {
      roles: ['student', 'applicant', 'staff', 'faculty', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    finaidOffice: {
      roles: ['student', 'applicant', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    finaidSummary: {
      roles: ['student', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    gradFinancialSupport: {
      roles: ['student', 'applicant', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    iGrad: {
      roles: ['student', 'applicant', 'staff', 'faculty', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    leavingCal: {
      roles: ['student', 'applicant', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    loanRepaymentCalculator: {
      roles: ['student', 'applicant', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    mealPlanBalance: {
      roles: ['student', 'applicant', 'exStudent'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    mealPlanLearn: {
      roles: ['student', 'applicant', 'exStudent'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    nslds: {
      roles: ['student', 'applicant', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    paymentOptions: {
      roles: ['student', 'applicant', 'exStudent'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    stateInstitutionalLoans: {
      roles: ['student', 'applicant', 'staff', 'faculty', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    studentAdvocateOffice: {
      roles: ['student', 'applicant', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    summerEstimator: {
      roles: ['student', 'applicant'],
      careers: ['UGRD'],
      allowsDelegateAccess: false,
      allowsSummerVisitor: false,
    },
    summerFees: {
      roles: ['student', 'applicant', 'exStudent'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: true,
    },
    summerSchedule: {
      roles: ['student', 'applicant', 'exStudent'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: true,
    },
    summerWebsite: {
      roles: ['student', 'applicant', 'exStudent'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    summerCancelWithdraw: {
      roles: ['student', 'applicant', 'exStudent'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: true,
    },
    tenNinetyEightT: {
      roles: ['student'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    tenNinetyEightTView: {
      roles: ['student'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: false,
      allowsSummerVisitor: false,
    },
    tuitionAndFees: {
      roles: ['student', 'applicant', 'exStudent'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    tuitionAndFPP: {
      roles: ['student'],
      excludedPrograms: ['GSSDP', 'LSSDPL'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    withdrawCancel: {
      roles: ['student', 'applicant', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
    workStudy: {
      roles: ['student', 'applicant', 'exStudent'],
      careers: ['UGRD', 'GRAD', 'LAW'],
      allowsDelegateAccess: true,
      allowsSummerVisitor: false,
    },
  };
  const currentLinkAccess = linkAccess[key];
  const hasPermittedRole = currentLinkAccess.roles
    ? roles.filter(value => currentLinkAccess.roles.includes(value)).length > 0
    : true;
  const hasPermittedCareer = currentLinkAccess.careers
    ? careers.filter(value => currentLinkAccess.careers.includes(value))
        .length > 0
    : true;
  const hasForbiddenProgram = currentLinkAccess.excludedPrograms
    ? programs.filter(value =>
        currentLinkAccess.excludedPrograms.includes(value)
      ).length > 0
    : false;
  const allowsDelegate =
    !delegate || (currentLinkAccess.allowsDelegateAccess && delegate)
      ? true
      : false;
  const allowsSummer = currentLinkAccess.allowsSummerVisitor && summer;

  return (
    (hasPermittedRole &&
      hasPermittedCareer &&
      !hasForbiddenProgram &&
      allowsDelegate) ||
    allowsSummer
  );
};

// HasAccessTo will only display links that are returned from Link API and accessible given
// the specified roles, careers, programs, and delegate access.
const HasAccessTo = ({
  linkNames,
  links,
  roles,
  careerCodes,
  programCodes,
  isDelegate,
  isSummerVisitor,
  children,
}) => {
  const hasAccessToAnyLink = linkNames.some(linkName => {
    if (getLink(linkName, links)) {
      return hasAccessToLink(
        linkName,
        roles,
        careerCodes,
        programCodes,
        isDelegate,
        isSummerVisitor
      );
    }
  });

  return hasAccessToAnyLink ? children : null;
};

HasAccessTo.propTypes = propTypes;

const mapStateToProps = ({
  myStatus = {},
  myAcademics: { collegeAndLevel: { plans = [] } = {} } = {},
}) => {
  const careerCodes = plans.map(plan => plan.career.code);
  const programCodes = plans.map(plan => plan.program.code);

  return {
    roles: activeRoles(myStatus.roles),
    careerCodes: careerCodes,
    programCodes: programCodes,
    isDelegate: myStatus.isDelegateUser,
    isSummerVisitor:
      myStatus.academicRoles.current.summerVisitor ||
      myStatus.academicRoles.historical.summerVisitor,
  };
};

export default connect(mapStateToProps)(HasAccessTo);