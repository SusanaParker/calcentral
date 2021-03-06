import React from 'react';
import PropTypes from 'prop-types';

import Category from '../Category';
import Task from '../Task';
import TaskHeader from '../TaskHeader';

// Overdue specific
import OverdueTasksHeader from './OverdueTasksHeader';
import OverdueIcon from '../Icons/OverdueIcon';
import TaskTitle from '../TaskTitle';

import { shortDateIfCurrentYear, parseDate } from 'functions/formatDate';

import { format, parseISO, isThisYear } from 'date-fns';

const dateWithTimeAndMaybeYear = time => {
  if (isThisYear(time)) {
    return format(time, 'MMM d, h a');
  } else {
    return format(time, 'MMM d y, h a');
  }
};

const BTaskSubtitle = ({ task }) => {
  return (
    <>
      <span
        style={{ color: `#999`, fontSize: `11px`, textTransform: `uppercase` }}
      >
        {task.courseCode}
      </span>
      <br />
      Due {dateWithTimeAndMaybeYear(parseISO(task.dueTime))}
    </>
  );
};

BTaskSubtitle.propTypes = {
  task: PropTypes.shape({
    courseCode: PropTypes.string,
    dueTime: PropTypes.string,
  }),
};

function OverdueTasks({ tasks }) {
  return (
    <Category>
      <OverdueTasksHeader>Overdue</OverdueTasksHeader>

      {tasks.map((task, index) => {
        const subtitle =
          task.displayCategory === 'bCourses' ? (
            <BTaskSubtitle task={task} />
          ) : (
            `Due ${shortDateIfCurrentYear(parseDate(task.dueDate))}`
          );

        return (
          <Task
            key={index}
            index={index}
            task={task}
            type="overdue"
            isOverdue={true}
          >
            <TaskHeader task={task} isOverdue={true}>
              <OverdueIcon />
              <TaskTitle
                title={task.title}
                subtitle={subtitle}
                overdue={true}
              />
            </TaskHeader>
          </Task>
        );
      })}
    </Category>
  );
}

OverdueTasks.propTypes = {
  categoryKey: PropTypes.string,
  tasks: PropTypes.array,
};

export default OverdueTasks;
