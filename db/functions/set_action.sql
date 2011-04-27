
CREATE or REPLACE FUNCTION set_action(
	tid		task.task_id%type,
	i_actionname	action.actionname%type
) RETURNS BOOLEAN AS $$
  declare	i_cur_action_id	task.cur_action_id%type;
  declare  	i_nextActionSeq	action.actionSequence%type;
  declare	i_cur_actionname	action.actionname%type;
  declare 	myrec record;
--   declare       i_cur_action_id_derived task.cur_action_id%type;

BEGIN

-- Algorithm:
-- First - 	Select out the current action associated to the task.
-- 
-- Second - 	If there is no action associated with the task, set it as
--			defined in the procedure argument.
--			Update the "cur_action_id" field.
-- Third -      If there is a current action defined, check to see if it is
--			the same as the procedure argument.  If it is; do nothing.
--			If it isn't ; set this as the current action and mark the
--			last action finished.

        RAISE DEBUG 'Calling set_action(%,%)', tid, i_actionname;

	  select	
	  into myrec
	    task.cur_action_id,
	    coalesce(actionSequence,-1) + 1 actionSequence
	  from	
	    task left outer join action on 
	      (task.cur_action_id = action.action_id)
	  where
	    task.task_id = tid;

        RAISE DEBUG 'derived myrec (%)', myrec;


	i_cur_action_id := myrec.cur_action_id;
	i_nextActionSeq := myrec.actionSequence;

        RAISE DEBUG 'derived i_cur_action_id, i_nextActionSeq (%,%)', i_cur_action_id, i_nextActionSeq;
--
-- No task defined. 
--
	if I_CUR_ACTION_ID IS NULL THEN
		insert into action
		(
			actionname,
			actionstatus,
			actionSequence,
			task_id
		) values
		(
			i_actionname,
			'new',
			i_nextActionSeq,
			tid
		);
		
		BEGIN
			select	action_id
			into	i_cur_action_id
			from	action
			where	task_id = tid
			and	actionSequence = i_nextActionSeq;
		EXCEPTION
			when no_data_found then
				null;
		END;

		update	task
		set	cur_action_id = i_cur_action_id
		where	task_id	= tid;
	ELSE
		select	actionname
		into	i_cur_actionname
		from	action
		where	action_id = i_cur_action_id;

		if i_actionname <> i_cur_actionname THEN
			update  action
			set 	actionstatus = 'succeeded'
			where	action_id = i_cur_action_id;

-- insert the new row; unless it is already there
-- if it is already there; set its status to 'retry'.

			i_cur_action_id := NULL;

			BEGIN
				select	action_id
				into	i_cur_action_id
				from	action
				where	task_id = tid
				and	actionSequence = i_nextActionSeq;
			EXCEPTION
				when no_data_found then
					null;
			END;

			if i_cur_action_id IS NULL THEN
				insert into action
				(
					actionname,
					actionstatus,
					actionSequence,
					task_id
				) values
				(
					i_actionname,
					'new',
					i_nextActionSeq,
					tid
				);
-- Not sure this following begin/end block is actually needed.
				BEGIN
					select	action_id
					into	i_cur_action_id
					from	action
					where	task_id = tid
					and	actionSequence = i_nextActionSeq;
				EXCEPTION
					when no_data_found then
						null;
				END;
			else
				update	action
				set	actionstatus = 'retry'
				where 	action_id = i_cur_action_id;
			end if;
	
			update	task
			set	cur_action_id = i_cur_action_id
			where	task_id	= tid;
		END IF;
	END IF;
        return NULL;
END;
$$ language plpgsql;
