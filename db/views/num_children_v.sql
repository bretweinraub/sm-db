select	task.task_id,
	task.status parent_status,
	coalesce(num_children,0) as num_children
from	task left outer join (
		select 	parent_task_id task_id,
		count	(*) AS num_children
		from	task
		where	parent_task_id is not null
		and	processed is null
		group	by parent_task_id
	) as parents on 
	(
	  task.task_id = parents.task_id
	)
