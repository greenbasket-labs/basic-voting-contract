// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title Voting
 * @author GreenBasket Labs
 * @notice A simple on-chain voting contract built as a learning milestone.
 * @dev This contract allows one vote per address and tracks votes transparently.
 */
contract Voting {
    struct Proposal {
        string name;
        uint256 voteCount;
    }

    address public admin;
    Proposal[] public proposals;
    mapping(address => bool) public hasVoted;

    /**
     * @notice Initializes the contract with proposal names
     * @param proposalNames Array of proposal names
     */
    constructor(string[] memory proposalNames) {
        admin = msg.sender;

        for (uint256 i = 0; i < proposalNames.length; i++) {
            proposals.push(
                Proposal({
                    name: proposalNames[i],
                    voteCount: 0
                })
            );
        }
    }

    /**
     * @notice Vote for a proposal by index
     * @param proposalId Index of the proposal
     */
    function vote(uint256 proposalId) external {
        require(!hasVoted[msg.sender], "Already voted");
        require(proposalId < proposals.length, "Invalid proposal");

        hasVoted[msg.sender] = true;
        proposals[proposalId].voteCount += 1;
    }

    /**
     * @notice Get proposal details
     * @param proposalId Index of the proposal
     */
    function getProposal(uint256 proposalId)
        external
        view
        returns (string memory name, uint256 voteCount)
    {
        require(proposalId < proposals.length, "Invalid proposal");

        Proposal storage proposal = proposals[proposalId];
        return (proposal.name, proposal.voteCount);
    }

    /**
     * @notice Get total number of proposals
     */
    function getProposalCount() external view returns (uint256) {
        return proposals.length;
    }
}
