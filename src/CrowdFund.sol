// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract CrowdFund {

    /* =============================================================
                            STEP 1
        Create the Campaign struct.
    ============================================================= */
    struct Campaign {
        address owner;
        uint256 goal;
        uint256 pledged;
        uint32 startAt; // Using uint32 saves gas for timestamps
        uint32 endAt;
        bool claimed;
    }

    /* =============================================================
                            STEP 2
       Create state variables.
    ============================================================= */
    uint256 public campaignCount;
    mapping(uint256 => Campaign) public campaigns;
    // Maps campaignId => userAddress => amountPledged
    mapping(uint256 => mapping(address => uint256)) public pledgedAmount;

    /* =============================================================
                            STEP 3
       Create the create() function.
    ============================================================= */
    function create(uint256 _goal, uint32 _duration) external {
        campaignCount += 1;

        campaigns[campaignCount] = Campaign({
            owner: msg.sender,
            goal: _goal,
            pledged: 0,
            startAt: uint32(block.timestamp),
            endAt: uint32(block.timestamp) + _duration,
            claimed: false
        });
    }

    /* =============================================================
                            STEP 4
       Create the pledge() function.
    ============================================================= */
    function pledge(uint256 _id) external payable {
        Campaign storage campaign = campaigns[_id];
        require(block.timestamp < campaign.endAt, "Campaign has ended");

        campaign.pledged += msg.value;
        pledgedAmount[_id][msg.sender] += msg.value;
    }

    /* =============================================================
                            STEP 5
       Create the claim() function.
    ============================================================= */
    function claim(uint256 _id) external {
        Campaign storage campaign = campaigns[_id];

        require(msg.sender == campaign.owner, "Not owner");
        require(block.timestamp >= campaign.endAt, "Not ended");
        require(campaign.pledged >= campaign.goal, "Goal not reached");
        require(!campaign.claimed, "Already claimed");

        campaign.claimed = true;
        payable(campaign.owner).transfer(campaign.pledged);
    }

    /* =============================================================
                            STEP 6
       Create the refund() function.
    ============================================================= */
    function refund(uint256 _id) external {
        Campaign storage campaign = campaigns[_id];

        require(block.timestamp >= campaign.endAt, "Not ended");
        require(campaign.pledged < campaign.goal, "Goal reached");

        uint256 amount = pledgedAmount[_id][msg.sender];
        require(amount > 0, "Nothing to refund");

        pledgedAmount[_id][msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }
}