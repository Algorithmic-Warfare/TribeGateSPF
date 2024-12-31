// SPDX-License-Identifier: MIT
pragma solidity >=0.8.24;

import { console } from "forge-std/console.sol";
import { ResourceId } from "@latticexyz/world/src/WorldResourceId.sol";
import { WorldResourceIdLib } from "@latticexyz/world/src/WorldResourceId.sol";
import { IBaseWorld } from "@latticexyz/world/src/codegen/interfaces/IBaseWorld.sol";
import { System } from "@latticexyz/world/src/System.sol";
import { RESOURCE_SYSTEM } from "@latticexyz/world/src/worldResourceTypes.sol";
import { IBaseWorld } from "@eveworld/world/src/codegen/world/IWorld.sol";
import { Utils } from "./Utils.sol";
import { WORLD_ADDRESS } from "./constants.sol";

/**
 * @dev This contract is an example for implementing logic to a smart gate
 */
contract TribeGateSPFSystem is System {
  function canJump(uint256 characterId, uint256 sourceGateId, uint256 destinationGateId) public returns (bool) {
    ResourceId systemId = Utils.smartGateSystemId();

    return
      abi.decode(
        IBaseWorld(WORLD_ADDRESS).call(
          systemId,
          abi.encodeCall(this.canJump, (characterId, sourceGateId, destinationGateId))
        ),
        (bool)
      );
  }
}
