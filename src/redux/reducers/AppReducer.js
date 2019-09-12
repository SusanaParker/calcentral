import { combineReducers } from 'redux';

import AcademicsReducer from './AcademicsReducer';
import ActivitiesReducer from './ActivitiesReducer';
import AdvisingReducer from './AdvisingReducer';
import BillingItemsReducer from './BillingItemsReducer';
import CarsDataReducer from './CarsDataReducer';
import CalGrantsReducer from './CalGrantsReducer';
import ConfigReducer from './ConfigReducer';
import HoldsReducer from './HoldsReducer';
import LawAwardsReducer from './LawAwardsReducer';
import StatusReducer from './StatusReducer';
import ProfileReducer from './ProfileReducer';
import RegistrationsReducer from './RegistrationsReducer';
import TransferCreditReducer from './TransferCreditReducer';
import LinksReducer from './LinksReducer';
import RouteReducer from './RouteReducer';
import StandingsReducer from './StandingsReducer';
import StatusAndHoldsReducer from './StatusAndHoldsReducer';

const AppReducer = combineReducers({
  advising: AdvisingReducer,
  config: ConfigReducer,
  currentRoute: RouteReducer,
  billingItems: BillingItemsReducer,
  carsData: CarsDataReducer,
  links: LinksReducer,
  myAcademics: AcademicsReducer,
  myActivities: ActivitiesReducer,
  myCalGrants: CalGrantsReducer,
  myHolds: HoldsReducer,
  myLawAwards: LawAwardsReducer,
  myProfile: ProfileReducer,
  myRegistrations: RegistrationsReducer,
  myStandings: StandingsReducer,
  myStatus: StatusReducer,
  myStatusAndHolds: StatusAndHoldsReducer,
  myTransferCredit: TransferCreditReducer
});

export default AppReducer;
