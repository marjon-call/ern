// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

import {AccessControl} from "./dependencies/@openzeppelin-contracts-5.3.0/access/AccessControl.sol";
import {Pausable} from "./dependencies/@openzeppelin-contracts-5.3.0/utils/Pausable.sol";
import {SafeERC20, IERC20} from "./dependencies/@openzeppelin-contracts-5.3.0/token/ERC20/utils/SafeERC20.sol";

/// @title RewardsDistributor
/// @notice Simple rewards distribution contract. Allocators add token allocations for users, who can then claim them.
/// @dev Uses AccessControl for role-based permissions. ALLOCATOR_ROLE can manage allocations, DEFAULT_ADMIN_ROLE can pause and emergency withdraw.
contract RewardsDistributor is AccessControl, Pausable {
    using SafeERC20 for IERC20;

    // ============ Roles ============

    bytes32 public constant ALLOCATOR_ROLE = keccak256("ALLOCATOR_ROLE");
    bytes32 public constant DISTRIBUTOR_ROLE = keccak256("DISTRIBUTOR_ROLE");

    // ============ Errors ============

    error AddressCannotBeZero();
    error NothingToClaim();
    error CannotReduceBelowClaimed();

    // ============ Types ============

    /// @notice Represents an allocation for a specific user
    /// @param user The address receiving the allocation
    /// @param amount The amount to allocate (added to existing for addAllocations, target value for reduceAllocations)
    struct Allocation {
        address user;
        uint256 amount;
    }

    // ============ Events ============

    event AllocationAdded(address indexed token, address indexed user, uint256 amount);
    event AllocationReduced(address indexed token, address indexed user, uint256 amount);
    event Claimed(address indexed token, address indexed user, uint256 amount);
    event EmergencyWithdraw(address indexed token, address indexed to, uint256 amount);

    // ============ State ============

    /// @notice Total allocation per token per user (cumulative)
    mapping(address => mapping(address => uint256)) public allocations;

    /// @notice Amount already claimed per token per user
    mapping(address => mapping(address => uint256)) public claimed;

    // ============ Constructor ============

    /// @notice Initializes the contract with an admin who receives both admin and allocator roles
    /// @param admin The address to grant DEFAULT_ADMIN_ROLE and ALLOCATOR_ROLE
    constructor(address admin) {
        _grantRole(DEFAULT_ADMIN_ROLE, admin);
        _grantRole(ALLOCATOR_ROLE, admin);
    }

    // ============ Admin Functions ============

    /// @notice Adds allocations for multiple users and pulls the required tokens from the caller
    /// @dev Caller must have approved this contract to spend the total amount of tokens
    /// @param token The ERC20 token address to allocate
    /// @param items Array of Allocation structs containing user addresses and amounts to add
    function addAllocations(address token, Allocation[] calldata items) external onlyRole(ALLOCATOR_ROLE) {
        _requireNonZeroAddress(token);

        uint256 total = 0;
        for (uint256 i = 0; i < items.length; i++) {
            _requireNonZeroAddress(items[i].user);
            allocations[token][items[i].user] += items[i].amount;
            total += items[i].amount;
            emit AllocationAdded(token, items[i].user, items[i].amount);
        }

        if (total > 0) {
            IERC20(token).safeTransferFrom(msg.sender, address(this), total);
        }
    }

    /// @notice Reduces allocations for multiple users and returns the excess tokens to the caller
    /// @dev Cannot reduce below the amount already claimed by each user
    /// @param token The ERC20 token address to reduce allocations for
    /// @param items Array of Allocation structs containing user addresses and new target allocation amounts
    function reduceAllocations(address token, Allocation[] calldata items) external onlyRole(ALLOCATOR_ROLE) {
        _requireNonZeroAddress(token);

        uint256 total = 0;
        for (uint256 i = 0; i < items.length; i++) {
            _requireNonZeroAddress(items[i].user);

            uint256 currentAllocation = allocations[token][items[i].user];
            uint256 newAllocation = items[i].amount;

            if (newAllocation < claimed[token][items[i].user]) revert CannotReduceBelowClaimed();

            if (newAllocation < currentAllocation) {
                uint256 reduction = currentAllocation - newAllocation;
                allocations[token][items[i].user] = newAllocation;
                total += reduction;
                emit AllocationReduced(token, items[i].user, reduction);
            }
        }

        if (total > 0) {
            IERC20(token).safeTransfer(msg.sender, total);
        }
    }

    /// @notice Claims tokens on behalf of multiple users, sending directly to them
    /// @param token The ERC20 token address to claim
    /// @param users Array of user addresses to claim for
    function claimFor(address token, address[] calldata users) external onlyRole(DISTRIBUTOR_ROLE) whenNotPaused {
        _requireNonZeroAddress(token);

        for (uint256 i = 0; i < users.length; i++) {
            _claimFor(token, users[i]);
        }
    }

    /// @notice Withdraws tokens from the contract in case of emergency or to recover mistakenly sent funds
    /// @param token The ERC20 token address to withdraw
    /// @param amount The amount of tokens to withdraw
    function emergencyWithdraw(address token, uint256 amount) external onlyRole(DEFAULT_ADMIN_ROLE) {
        _requireNonZeroAddress(token);

        IERC20(token).safeTransfer(msg.sender, amount);
        emit EmergencyWithdraw(token, msg.sender, amount);
    }

    /// @notice Withdraws all ETH sent to the contract (likely by mistake)
    function emergencyWithdrawETH() external onlyRole(DEFAULT_ADMIN_ROLE) {
        (bool success,) = msg.sender.call{value: address(this).balance}("");
        require(success, "ETH transfer failed");
    }

    /// @notice Pauses all claim operations
    function pause() external onlyRole(DEFAULT_ADMIN_ROLE) {
        _pause();
    }

    /// @notice Unpauses claim operations
    function unpause() external onlyRole(DEFAULT_ADMIN_ROLE) {
        _unpause();
    }

    // ============ User Functions ============

    /// @notice Claims all available tokens for the caller
    /// @param token The ERC20 token address to claim
    function claim(address token) external whenNotPaused {
        if (_claimFor(token, msg.sender) == 0) revert NothingToClaim();
    }

    // ============ View Functions ============

    /// @notice Returns the amount of tokens available to claim for a user
    /// @param token The ERC20 token address to check
    /// @param user The user address to check
    /// @return The amount of tokens available to claim
    function claimable(address token, address user) public view returns (uint256) {
        uint256 allocated = allocations[token][user];
        uint256 alreadyClaimed = claimed[token][user];

        if (allocated <= alreadyClaimed) return 0;
        return allocated - alreadyClaimed;
    }

    // ============ Internal ============

    function _claimFor(address token, address user) private returns (uint256) {
        uint256 amountToClaim = claimable(token, user);
        if (amountToClaim == 0) return 0;

        claimed[token][user] = allocations[token][user];
        IERC20(token).safeTransfer(user, amountToClaim);
        emit Claimed(token, user, amountToClaim);

        return amountToClaim;
    }

    function _requireNonZeroAddress(address addr) private pure {
        if (addr == address(0)) revert AddressCannotBeZero();
    }
}
