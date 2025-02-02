params ["_hideGroupIndex"];

_groupArray = missionNamespace getVariable format ["dives_hiddenUnits_%1", _hideGroupIndex];
{
    _x enableSimulationGlobal true;
	_x hideObjectGlobal false;
} foreach _groupArray;