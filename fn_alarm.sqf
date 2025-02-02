fn_alarmServer = {
	{
		[_x,""] remoteExec ["switchMove", 0];
		_x enableAi "all";
	} forEach units west;
};