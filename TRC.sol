// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/token/ERC20/ERC20Upgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20BurnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

contract MetaTraceGovernanceToken is Initializable, ERC20Upgradeable, ERC20BurnableUpgradeable, PausableUpgradeable, OwnableUpgradeable, UUPSUpgradeable {
    constructor() {
        _disableInitializers();
    }

    function initialize() initializer public {
        __ERC20_init("MetaTrace Governance Token", "TRC");
        __ERC20Burnable_init();
        __Pausable_init();
        __Ownable_init();
        __UUPSUpgradeable_init();

        _mint(msg.sender, 5000000000 * 10 ** decimals());
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    function _beforeTokenTransfer(address from, address to, uint256 amount)
        internal
        whenNotPaused
        override
    {
        super._beforeTokenTransfer(from, to, amount);
    }

    function decimals() public view virtual override returns (uint8) {
        return 2;
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        onlyOwner
        override
    {}

    function renounceOwnership() public virtual override onlyOwner {
        revert("Renounce Ownership forbidden");
    }
}
//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "trc.sol";

contract MetaTrace is MetaTraceGovernanceToken {
    function name() public view virtual override returns (string memory) {
        return "MetaTrace";
    }
}