import React, { Fragment } from 'react';
import PropTypes from 'prop-types';
import { connect } from 'react-redux';

import { isPast, parseDate } from 'functions/formatDate';

import {
  groupByAidYear,
  incompleteTaskCategories,
  groupByCategory,
} from '../tasks.module.js';

import Agreements from './Agreements';
import OverdueTasks from '../OverdueTasks';
import FinancialAidTasks from '../IncompleteFinancialAidTasks';
import ForCategory from './ForCategory.js';

import tasksStyles from '../TasksCard.module.scss';

const ByCategory = ({ categories }) => {
  return (
    <Fragment>
      <div className={tasksStyles.textContainer}>
        <p>Click &quot;View&quot; to see tasks, due dates, and instructions.</p>
      </div>

      {categories.map(category => {
        if (category.key === 'agreements' && category.tasks.length > 0) {
          return (
            <Agreements
              key={category.key}
              category={category}
              tasks={category.tasks}
            />
          );
        } else if (category.key === 'overdue' && category.tasks.length > 0) {
          return <OverdueTasks key={category.key} tasks={category.tasks} />;
        } else if (category.key === 'financialAid') {
          return (
            <FinancialAidTasks
              key={category.key}
              aidYears={category.aidYears}
            />
          );
        } else if (category.tasks.length > 0) {
          return <ForCategory key={category.key} category={category} />;
        }

        return null;
      })}
    </Fragment>
  );
};

ByCategory.propTypes = {
  categories: PropTypes.array,
};

// The OVERDUE_ENABLED flag makes it easy to disable the "overdue" grouping for
// development purposes - desirable if development data is out of date and most
// items are showing up in "Overdue" rather their normal categories.
const OVERDUE_ENABLED = true;

const filterOverdueTasksIf = enabled => shouldFilter => {
  if (enabled) {
    if (shouldFilter) {
      return item => !item.isOverdue;
    } else {
      return _item => true;
    }
  } else {
    return _item => true;
  }
};

const markOverdue = enabled => item => {
  if (enabled) {
    if (item.displayCategory === 'financialAid') {
      return item;
    } else {
      return { ...item, isOverdue: isPast(parseDate(item.dueDate)) };
    }
  } else {
    return { ...item, isOverdue: false };
  }
};

const mapStateToProps = ({
  myChecklistItems: { incompleteItems = [] },
  myAgreements: { incompleteAgreements = [] },
}) => {
  const groupedByCategory = [...incompleteItems, ...incompleteAgreements]
    .map(markOverdue(OVERDUE_ENABLED))
    .reduce(groupByCategory, {});

  const orderedCategories = incompleteTaskCategories.map(category => {
    const items = groupedByCategory[category.key] || [];

    const sortedItems = items
      .filter(filterOverdueTasksIf(OVERDUE_ENABLED)(category.key !== 'overdue'))
      .reverse()
      .sort((a, b) => {
        if (category.key !== 'financialAid') {
          return a.dueDate > b.dueDate ? 1 : -1;
        } else {
          return a.assignedDate < b.assignedDate ? 1 : -1;
        }
      });

    if (category.key === 'financialAid') {
      const byAidYear = groupByAidYear(items);
      const aidYears = Object.keys(byAidYear)
        .sort((a, b) => b - a)
        .map(year => ({ year, tasks: byAidYear[year] }));

      return {
        ...category,
        aidYears,
      };
    } else if (category.key === 'agreements') {
      return {
        ...category,
        tasks: incompleteAgreements,
      };
    } else {
      return {
        ...category,
        tasks: sortedItems || [],
      };
    }
  });

  return {
    categories: orderedCategories,
  };
};

export default connect(mapStateToProps)(ByCategory);