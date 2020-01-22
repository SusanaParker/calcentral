import React from 'react';
import PropTypes from 'prop-types';

import styles from './TaskDetail.module.scss';
import APILink from 'react/components/APILink';

const TaskDetail = ({ task }) => {
  const {
    actionText,
    actionUrl,
    departmentName,
    description,
    hasUpload,
    uploadUrl,
    url,
  } = task;

  const descriptionStyles = `cc-break-word cc-clearfix cc-text-pre-line ${styles.description}`;
  const actionStyles = `cc-button cc-widget-tasks-button cc-outbound-link ${styles.actionLink}`;

  return (
    <div className={styles.wrapper}>
      {departmentName && (
        <p>
          <strong>From {departmentName}</strong>
        </p>
      )}

      <div className={descriptionStyles}>{description}</div>

      {url && (
        <APILink
          {...url}
          name="Respond"
          className="cc-button"
          style={{ marginTop: `10px`, display: `block`, textAlign: `center` }}
        />
      )}

      {actionUrl && (
        <a
          className={actionStyles}
          href={actionUrl}
          onClick={e => e.stopPropagation()}
        >
          {actionText}
        </a>
      )}

      {hasUpload && (
        <APILink
          {...uploadUrl}
          name="Upload"
          className="cc-button"
          style={{ marginTop: `10px`, display: `inline-block` }}
        />
      )}
    </div>
  );
};

TaskDetail.propTypes = {
  task: PropTypes.shape({
    actionText: PropTypes.string,
    actionUrl: PropTypes.string,
    departmentName: PropTypes.string,
    description: PropTypes.string,
    dueDate: PropTypes.string,
    hasUpload: PropTypes.bool,
    uploadUrl: PropTypes.object,
    url: PropTypes.object,
  }),
};

export default TaskDetail;