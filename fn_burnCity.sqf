destructionBlacklist = createHashMap;

fn_destroyBuildingsInTrigger = {
	params ["_trigger", ["_buildingDestructionChance", 0.5], ["_excludeTriggers", []]];

	_fn_isNotInExcludedArea = {
		params ["_object", "_trigger", "_excludeTriggers"];
		
		_excluded = false;
		if (not isNil "_excludeTriggers") then {
			for "_t" from 0 to (count _excludeTriggers) - 1 do 
			{ 
				_exclude = _excludeTriggers select _t;
				if (_object inArea _exclude) then {
					_excluded = true;
				};
			};
		};
		if (_excluded) exitWith {false};
		true
	};
	
	_fn_getObjectsInTrigger = {
		params ["_trigger", "_classes"];
		
		// Get buildings in trigger
		_area = triggerArea _trigger;
		_radius = if (_area select 3) then { // isRectangle
			sqrt ((_area select 0) ^ 2 + (_area select 1) ^ 2)
		} else { selectMax (_area select [0, 2]) };
		_buildings = (nearestTerrainObjects [_trigger, _classes, _radius, false]) inAreaArray _trigger;
		_buildings
	};
	
	_fn_applyDamage = {
		params ["_objects", "_chance", "_damageTrue", "_excludeTriggers"];
		
		for "_i" from 0 to (count _objects) - 1 do 
		{ 
			_object = _objects select _i;
			
			// Avoid damaging objects twice
			_objectId = getObjectID _object;
			_blacklistedObject = destructionBlacklist get _objectId;
			if (not isNil "_blacklistedObject") then {
				continue
			};
			destructionBlacklist set [_objectId, True];
			
			_isExcluded = not ([_object, _trigger, _excludeTriggers] call _fn_isNotInExcludedArea);
			
			_targetDamage = 0.0;
			if (not _isExcluded) then {
				_shouldBeDestroyed = random 1 < _chance;
				if (_shouldBeDestroyed) then { 
					_targetDamage = _damageTrue; 
					_object setDamage [_targetDamage, false];
					
					_bomb = "APERSTripMine_Wire_Ammo" createVehicle ((getPosATL _object) vectorAdd [0, 0, 2]);
					//_bomb = "IEDLandSmall_Remote_Ammo" createVehicle ((getPosATL _object) vectorAdd [0, 0, 2]);
					_bomb setdamage 1;
					
					_fire = "Land_SPE_FX_Big_Fire" createVehicle ((getPosATL _object) vectorAdd [0, 0, 2]);
					
					sleep 0.1 + (random 1.5);
				};
			};
		};
	};

	_buildings = [_trigger, ["BUILDING", "HOSPITAL", "HOUSE"]] call _fn_getObjectsInTrigger;
	_buildings = _buildings call BIS_fnc_arrayShuffle;
	[_buildings, _buildingDestructionChance, 0.7, _excludeTriggers] call _fn_applyDamage;

};

fn_burnCityServer = {
	[destruction_trigger_0, 0.3, [destruction_safezone_0, destruction_safezone_1, destruction_safezone_2]] call fn_destroyBuildingsInTrigger;
	//diag_log str(destructionBlacklist);
};