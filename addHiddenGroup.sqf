params ["_theTrigger", "_hideGroupIndex", ["_includeProps", false]];

_varName = format ["dives_hiddenUnits_%1", _hideGroupIndex];
if (isNil _varName) then {
	missionNamespace setVariable [_varName, [], true];
};

_objectsToHide = [];
if (_includeProps) then {
	_objectsToHide = allMissionObjects "All" inAreaArray _theTrigger;
} else {
	_objectsToHide = allUnits inAreaArray _theTrigger;
	_objectsToHide append (vehicles inAreaArray _theTrigger);
};

_groupArray = missionNamespace getVariable format ["dives_hiddenUnits_%1", _hideGroupIndex];
_groupArray append _objectsToHide;

{
    _x enableSimulationGlobal false;
	_x hideObjectGlobal true;
} foreach _objectsToHide;