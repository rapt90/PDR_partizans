fn_alarmServer = {
	{
		if (_x inArea destruction_trigger_0) then {
			[_x,""] remoteExec ["switchMove", 0];
			_x enableAi "all";
		};
	} forEach units west;
};