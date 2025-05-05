// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DecentralizedLottery {
    address public owner;
    uint public ticketPrice;
    uint public roundDuration;
    uint public roundEnd;
    address[] public players;
    bool public roundActive;
    uint public roundNumber;
    address public lastWinner;

    event TicketPurchased(address indexed player, uint round);
    event RoundStarted(uint indexed round, uint endTime);
    event RoundEnded(uint indexed round, address winner, uint prizeAmount);
    event PrizeClaimed(address indexed winner, uint amount);

    constructor(uint _ticketPrice, uint _roundDurationMinutes) {
        owner = msg.sender;
        ticketPrice = _ticketPrice;
        roundDuration = _roundDurationMinutes * 1 minutes;
        roundNumber = 1;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier isRoundActive() {
        require(roundActive, "No active round");
        require(block.timestamp < roundEnd, "Round has ended");
        _;
    }

    function startRound() public onlyOwner {
        require(!roundActive, "Previous round still active");
        delete players;
        roundActive = true;
        roundEnd = block.timestamp + roundDuration;
        emit RoundStarted(roundNumber, roundEnd);
    }

    function buyTicket() public payable isRoundActive {
        require(msg.value == ticketPrice, "Incorrect ticket price");
        players.push(msg.sender);
        emit TicketPurchased(msg.sender, roundNumber);
    }

    function endRoundAndPickWinner() public onlyOwner {
        require(roundActive, "Round not active");
        require(block.timestamp >= roundEnd, "Round still ongoing");
        require(players.length > 0, "No players in round");

        uint winnerIndex = uint(
            keccak256(
                abi.encodePacked(block.timestamp, keccak256(abi.encodePacked(block.timestamp)), players.length)
            )
        ) % players.length;

        address winner = players[winnerIndex];
        uint prize = address(this).balance;

        roundActive = false;
        lastWinner = winner;
        roundNumber++;

        payable(winner).transfer(prize);

        emit RoundEnded(roundNumber - 1, winner, prize);
        emit PrizeClaimed(winner, prize);
    }

    function getPlayers() public view returns (address[] memory) {
        return players;
    }

    function timeLeftInRound() public view returns (uint) {
        if (block.timestamp >= roundEnd || !roundActive) {
            return 0;
        }
        return roundEnd - block.timestamp;
    }

    function contractBalance() public view returns (uint) {
        return address(this).balance;
    }
}
