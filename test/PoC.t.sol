// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "forge-std/Test.sol";

// ============================================================
// Minimal Interfaces — ERN Protocol
// ============================================================

interface IERC20 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transfer(address to, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
}

interface IErn is IERC20 {
    struct UserInfo {
        uint256 lastCumulativeRewardPerShare;
        uint256 rewardClaimed;
        uint256 depositTimestamp;
    }

    function REWARD_TOKEN() external view returns (address);
    function UNDERLYING() external view returns (address);
    function DEX() external view returns (address);
    function AAVE_ADDRESSES() external view returns (address);
    function getAavePool() external view returns (address);
    function getAaveUnderlying() external view returns (address);

    function owner() external view returns (address);
    function totalAssets() external view returns (uint256);
    function harvestFee() external view returns (uint256);
    function withdrawFee() external view returns (uint256);
    function cumulativeRewardPerShare() external view returns (uint256);
    function lockPeriod() external view returns (uint256);
    function hardLockPeriod() external view returns (uint256);
    function lastHarvest() external view returns (uint256);
    function harvestCooldown() external view returns (uint256);
    function minYieldAmount() external view returns (uint256);
    function harvestTimePeriod() external view returns (uint256);
    function isHarvester(address account) external view returns (bool);
    function isLocked(address user) external view returns (bool);
    function isHardLocked(address user) external view returns (bool);
    function unlockTime(address user) external view returns (uint256);
    function claimableYield(address user) external view returns (uint256);
    function applicableFee(address user, uint256 amount) external view returns (uint256 amountAfterFee, uint256 feeAmount);
    function users(address user) external view returns (uint256 lastCumulativeRewardPerShare, uint256 rewardClaimed, uint256 depositTimestamp);
    function canHarvest() external view returns (bool, uint256);

    function deposit(uint256 amount) external;
    function withdraw(uint256 amount) external;
    function harvest(uint256 minOut) external;
    function claimYield() external;
    function claimYieldOnBehalf(address user) external;
}

interface IRewardsDistributor {
    struct Allocation {
        address user;
        uint256 amount;
    }

    function DEFAULT_ADMIN_ROLE() external view returns (bytes32);
    function ALLOCATOR_ROLE() external view returns (bytes32);
    function DISTRIBUTOR_ROLE() external view returns (bytes32);
    function hasRole(bytes32 role, address account) external view returns (bool);
    function getRoleAdmin(bytes32 role) external view returns (bytes32);
    function allocations(address token, address user) external view returns (uint256);
    function claimed(address token, address user) external view returns (uint256);
    function claimable(address token, address user) external view returns (uint256);
    function paused() external view returns (bool);

    function addAllocations(address token, Allocation[] calldata items) external;
    function reduceAllocations(address token, Allocation[] calldata items) external;
    function claim(address token) external;
    function claimFor(address token, address[] calldata users) external;
    function emergencyWithdraw(address token, uint256 amount) external;
    function pause() external;
    function unpause() external;
}

// ============================================================
// PoC Test
// ============================================================

contract PoC is Test {

    // --- DIRECT ADDRESSES (not behind proxy) ---
    IErn constant ernUSDT = IErn(0x87f0E6f65CCf64d6D504C9DB95F390d2aCb033B5);
    IErn constant ernUSDC = IErn(0x226455A82E30Ff05E68B37b99C59e503104bA84B);
    IRewardsDistributor constant rewardsDistributor = IRewardsDistributor(0x9F76037494092aCeAc5B23E21C20B1970a866eF5);

    // --- External tokens ---
    IERC20 constant USDT  = IERC20(0xdAC17F958D2ee523a2206206994597C13D831ec7);
    IERC20 constant USDC  = IERC20(0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48);
    IERC20 constant WBTC  = IERC20(0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599);

    // --- Protocol external dependencies ---
    address constant UNISWAP_V3_ROUTER = 0xE592427A0AEce92De3Edee1F18E0157C05861564;
    address constant AAVE_ADDRESSES_PROVIDER = 0x2f39d218133AFaB8F2B819B1066c7E434Ad94E9e;

    // --- Protocol owner ---
    address constant OWNER = 0xeA361071D4E88665E79ce3bd1d8DaDb5755C3bed;

    // --- Test actors ---
    address attacker = makeAddr("attacker");
    address victim   = makeAddr("victim");

    function setUp() public {
        vm.createSelectFork(vm.envString("MAINNET_RPC_URL"));
    }

    function test_PoC() public {
        // --- Write your PoC here ---
    }

}
