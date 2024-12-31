// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;
import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/console.sol";
import { ResourceId, WorldResourceIdLib } from "@latticexyz/world/src/WorldResourceId.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { IBaseWorld } from "@latticexyz/world/src/codegen/interfaces/IBaseWorld.sol";

import { Utils } from "../src/systems/Utils.sol";
import { Utils as SmartGateUtils } from "@eveworld/world/src/modules/smart-gate/Utils.sol";
import { SmartGateLib } from "@eveworld/world/src/modules/smart-gate/SmartGateLib.sol";
import { FRONTIER_WORLD_DEPLOYMENT_NAMESPACE } from "@eveworld/common-constants/src/constants.sol";

contract ConfigureSmartGate is Script {
  using SmartGateUtils for bytes14;
  using SmartGateLib for SmartGateLib.World;

  SmartGateLib.World smartGate;

  function run(address worldAddress) external {
    // Load a list of smart gate ids from a json file
    string memory json = vm.readFile("smartGateIds.json");
    uint256[] memory smartGateIds = vm.parseJsonUintArray(json, ".smartGateIds");

    // Load the private key from the `PRIVATE_KEY` environment variable (in .env)
    uint256 privateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(privateKey);

    StoreSwitch.setStoreAddress(worldAddress);
    IBaseWorld world = IBaseWorld(worldAddress);

    smartGate = SmartGateLib.World({ iface: IBaseWorld(worldAddress), namespace: FRONTIER_WORLD_DEPLOYMENT_NAMESPACE });

    ResourceId systemId = Utils.smartGateSystemId();

    // Cycle through the smart gate IDs and configure the smart gate
    for (uint256 i = 0; i < smartGateIds.length; i++) {
      smartGate.configureSmartGate(smartGateIds[i], systemId);
    }

    vm.stopBroadcast();
  }
}
