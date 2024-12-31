// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;
import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/console.sol";
import { ResourceId, WorldResourceIdLib } from "@latticexyz/world/src/WorldResourceId.sol";
import { ResourceIds } from "@latticexyz/store/src/codegen/tables/ResourceIds.sol";
import { StoreSwitch } from "@latticexyz/store/src/StoreSwitch.sol";
import { IBaseWorld } from "@latticexyz/world/src/codegen/interfaces/IBaseWorld.sol";

import { Utils } from "../src/systems/Utils.sol";
import { SmartGateLib } from "@eveworld/world/src/modules/smart-gate/SmartGateLib.sol";
import { FRONTIER_WORLD_DEPLOYMENT_NAMESPACE } from "@eveworld/common-constants/src/constants.sol";
import { Utils as SmartGateUtils } from "@eveworld/world/src/modules/smart-character/Utils.sol";
import { CharactersByAddressTable } from "@eveworld/world/src/codegen/tables/CharactersByAddressTable.sol";

contract CanJump is Script {
  using SmartGateUtils for bytes14;
  using SmartGateLib for SmartGateLib.World;

  SmartGateLib.World smartGate;

  function run(
    address worldAddress,
    address characterAddress,
    uint256 sourceGateId,
    uint256 destinationGateId
  ) external {
    // Load the private key from the `PRIVATE_KEY` environment variable (in .env)
    uint256 playerPrivateKey = vm.envUint("PRIVATE_KEY");
    vm.startBroadcast(playerPrivateKey);

    StoreSwitch.setStoreAddress(worldAddress);
    IBaseWorld world = IBaseWorld(worldAddress);

    smartGate = SmartGateLib.World({ iface: IBaseWorld(worldAddress), namespace: FRONTIER_WORLD_DEPLOYMENT_NAMESPACE });

    uint256 smartCharacterId = CharactersByAddressTable.getCharacterId(characterAddress);

    console.log("%s > %s", sourceGateId, destinationGateId);
    console.log("Can Jump:", smartGate.canJump(smartCharacterId, sourceGateId, destinationGateId));

    console.log("%s > %s", destinationGateId, sourceGateId);
    console.log("Can Jump:", smartGate.canJump(smartCharacterId, destinationGateId, sourceGateId));

    vm.stopBroadcast();
  }
}
