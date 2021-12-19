// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ShahNft is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenId;
    mapping(string => uint256) hashes;
    mapping(uint256 => string) private _tokenURIs;

    constructor() ERC721("Shah NFT", "SNFT") {}

    function createNFT(
        address recipient,
        string memory hash,
        string memory metadata
    ) public returns (uint256) {
        require(hashes[hash] != 1, "Already Known this NFT");

        hashes[hash] = 1;

        _tokenId.increment();

        uint256 newItemId = _tokenId.current();

        _mint(recipient, newItemId);

        _setTokenURI(newItemId, metadata);

        return newItemId;
    }

    function _setTokenURI(uint256 tokenId, string memory _tokenURI)
        internal
        virtual
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI set of nonexistent token"
        );
        _tokenURIs[tokenId] = _tokenURI;
    }
}
