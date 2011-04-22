select	task.task_id,
	task.status parent_status,
        CASE num_children when NULL
	  THEN 0
          ELSE num_children
        END as NUM_CHILDREN
from	(
		select 	parent_task_id task_id,
		count	(*) AS num_children
		from	task
		where	parent_task_id is not null
		and	processed is null
		group	by parent_task_id
	) parents left outer join task on
	(
	  task.task_id = parents.task_id
	)
