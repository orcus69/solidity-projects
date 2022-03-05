## How this smartcontract works
**Voting.sol** is the written contract, in it you can create a voting agenda that any user can vote on.
If a user tries to vote twice on the same agenda or changes their vote, smartcontrat will block the transaction.
This happens because the user's address is stored in a bool map, so if the user's address is true the user has already voted if not he can vote.

The administrator is the one who created the agenda, he is the same one who deployerd the contract