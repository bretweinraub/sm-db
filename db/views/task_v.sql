select	/*+ USE_HASH(task action) */
	task.TASK_NAME,
	task.DESCRIPTION,
	task.STATUS,
	task.TASKNAME,
	task.FAILUREREASON,
	task.CUR_ACTION_ID,
	task.CHAINGANG_ID,
	task.TASK_ID,
	task.created_at task_created_at,
	task.updated_at task_updated_at,
	task.PARENT_TASK_ID,
	task.start_by,
	task.task_group,
	task.mapper,
	action.ACTIONNAME,
	action.NUMFAILURES,
	action.ACTIONSTATUS,
	action.ACTIONPID,
	action.OUTPUTURL,
	action.action_id,
	action.callbacks,
	action.actionmapper,
	action.export_filter
from	task left outer join action on 
	(
		  task.task_id = action.task_id
		and
		  task.cur_action_id = action.action_id
        )

