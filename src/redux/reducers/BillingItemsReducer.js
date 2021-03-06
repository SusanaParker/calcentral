/* eslint camelcase: 0 */
// TODO: change API to camelcase

import { parseISO, differenceInCalendarDays, startOfToday } from 'date-fns';

import {
  FETCH_BILLING_ITEMS_START,
  FETCH_BILLING_ITEMS_SUCCESS,
  FETCH_BILLING_ITEMS_FAILURE,
  FETCH_BILLING_ITEM_START,
  FETCH_BILLING_ITEM_SUCCESS,
  FETCH_BILLING_ITEM_FAILURE,
} from '../action-types';

import { chargeTypes } from '../../react/components/_finances/TransactionsCard/types';

import {
  CHARGE_OVERDUE,
  CHARGE_DUE,
  CHARGE_NOT_DUE,
  CHARGE_PAID,
} from 'react/components/_finances/TransactionsCard/chargeStatuses';

const dueStatus = item => {
  if (!chargeTypes.has(item.type)) {
    return null;
  }

  if (item.amount_due <= 0) {
    return CHARGE_PAID;
  }

  if (item.due_date === null) {
    return CHARGE_NOT_DUE;
  }

  const daysPastDue = differenceInCalendarDays(
    startOfToday(),
    parseISO(item.due_date)
  );

  if (daysPastDue > 0) {
    return CHARGE_OVERDUE;
  }

  if (daysPastDue >= -15) {
    return CHARGE_DUE;
  }

  if (daysPastDue < -15) {
    return CHARGE_NOT_DUE;
  }
};

const setDate = item => {
  if (item.due_date === null) {
    return item;
  } else {
    return { ...item, due_date: parseISO(item.due_date) };
  }
};

const appendChargeStatus = item => ({ ...item, status: dueStatus(item) });

const updateItemDetails = (state, newItem) => {
  const items = state.items.map(item => {
    if (newItem.id === item.id) {
      return { ...item, ...newItem };
    }

    return item;
  });

  return { ...state, items };
};

const BillingItemsReducer = (state = {}, action) => {
  switch (action.type) {
    case FETCH_BILLING_ITEMS_START:
      return { ...state, isLoading: true, error: null };
    case FETCH_BILLING_ITEMS_FAILURE:
      return { ...state, isLoading: false, error: action.value };
    case FETCH_BILLING_ITEMS_SUCCESS:
      return {
        ...state,
        items: action.value.map(setDate).map(appendChargeStatus),
        isLoading: false,
        loaded: true,
        error: null,
      };
    case FETCH_BILLING_ITEM_START:
      return updateItemDetails(state, {
        id: action.value,
        isLoadingPayments: true,
        loadingPaymentsError: null,
      });
    case FETCH_BILLING_ITEM_SUCCESS:
      return updateItemDetails(state, {
        ...action.value,
        isLoadingPayments: false,
        loadedPayments: true,
        loadingPaymentsError: null,
      });
    case FETCH_BILLING_ITEM_FAILURE:
      return updateItemDetails(state, {
        ...state.items.find(item => item.id === action.id),
        isLoadingPayments: false,
        loadingPaymentsError: action.value,
      });
    default:
      return state;
  }
};

export default BillingItemsReducer;
