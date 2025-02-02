[] call compile preProcessFilelineNumbers "module_chatIntercept\config.sqf";
[] call compile preProcessFilelineNumbers "module_chatIntercept\commands.sqf";

pvpfw_chatIntercept_executeCommand = compile preProcessFilelineNumbers "module_chatIntercept\executeCommand.sqf";

[] call compile preProcessFilelineNumbers "module_chatIntercept\init.sqf";