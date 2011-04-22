select	parentV.task_id,
	num_children,
	parent_status,
	child_status,
	case num_child_tasks
	when NULL
	then 0
	else num_child_tasks
	end as num_child_tasks,
	task_name,
	taskname,
	cur_action_id action_id,
	actionname
from	num_children_v AS parentV left outer join 
	(
		select 	parent_task_id task_id,
			status child_status,
			count(*) num_child_tasks
		from	task
		where	parent_task_id is not null
		and	processed is null
		group	by
			parent_task_id,
			status
	) childV on (
		parentV.task_id = childV.task_id
	),
	task_v
where	parentV.task_id = task_v.task_id



