# Decentralized Lottery Smart Contract

## Description:
This is a decentralized lottery system built with Solidity and deployed on the Holesky testnet. Players can buy tickets, and after a timed round, the contract randomly selects a winner to receive the full prize pool.

---

## Features
- 🎟 Fixed-price ticket sales
- ⏱ Time-based lottery rounds
- 👥 Multiple players per round
- 🎲 Random winner selection (for demo/testing only)
- 💰 Automatic prize distribution

---

## How to Run (Remix + MetaMask)

1. Copy `Lottery.sol` into [Remix IDE](https://remix.ethereum.org)
2. Compile with Solidity ^0.8.x
3. Deploy using **Injected Provider - MetaMask**
   - Network: **Holesky Testnet**
   - Constructor params: `ticketPrice = 1000000000000000`, `roundDuration = 2`
4. Interact with the contract:
   - `startRound()` to begin
   - `buyTicket()` with 0.001 ETH
   - `endRoundAndPickWinner()` when time runs out

---

## Deployment Info

- **Network:** Holesky Testnet
- **Contract Address:** `0x2604317a064F6a388a9b9a3A3f099Fd9C43C1F08`
- **Deployed with:** MetaMask + Remix

---

## Author

Ranjit Singh – [GitHub Profile](https://github.com/rnjxt)

