pvpfw_chatIntercept_allCommands = [
	[
		"help",
		{
			_commands = "";
			{
				_commands = _commands + (pvpfw_chatIntercept_commandMarker + (_x select 0)) + ", ";
			}forEach pvpfw_chatIntercept_allCommands;
			systemChat format["Available Commands: %1",_commands];
		}
	],
	[
		"jump",
		{player setVelocity [0,0,3]}
	],
	[
		"doBurn",
		{
			[] remoteExec ["fn_burnCityServer", 2];
		}
	],
	[
		"doAirdrop",
		{
			[[1], "showHiddenGroup.sqf"] remoteExec ["execVM",2];
		}
	]
];