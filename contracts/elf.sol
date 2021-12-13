//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract ElfNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    string private _collectionURI;

    // The whitelist of reindeers
    mapping(address => bool) public reindeerWhitelist;

    // The whitelist of token holders
    mapping(address => bool) public tokenHolderWhitelist;

    // The public mint price
    uint256 public elfPrice;

    constructor() ERC721("Elf DAO NFT", "ELFDAO") {
        setCollectionURI(""); // TODO: set collection URI
        elfPrice = 0.08 ether; // TODO: decide on price
    }

    function setElfPrice(uint256 _price) public onlyOwner  {
      elfPrice = _price;
    }

    function mintNFT(address recipient, string memory tokenURI) public onlyOwner returns (uint256)
    {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
        _setTokenURI(newItemId, tokenURI);
        return newItemId;
    }

    /**
     * @dev for reindeer whitelist
     */
    function setReindeerWhitelist(
        address[] memory _addresses
    ) public onlyOwner {
        for (uint256 i = 0; i < _addresses.length; i++) {
            require(
                _addresses[i] != address(0),
                "can't add the blackhole address"
            );
            reindeerWhitelist[_addresses[i]] = true;
        }
    }


    /**
     * @dev reverse mistakes for for reindeer whitelist
     */
    function removeReindeerWhitelists(address[] memory _addresses) public onlyOwner {
        for (uint256 i = 0; i < _addresses.length; i++) {
            reindeerWhitelist[_addresses[i]] = false;
        }
    }


    /**
     * @dev for token holder whitelist
     */
    function setTokenHolderWhitelist(
        address[] memory _addresses
    ) public onlyOwner {
        for (uint256 i = 0; i < _addresses.length; i++) {
            require(
                _addresses[i] != address(0),
                "can't add the blackhole address"
            );
            tokenHolderWhitelist[_addresses[i]] = true;
        }
    }


    /**
     * @dev reverse mistakes for for token whitelist
     */
    function removeTokenWhitelists(address[] memory _addresses) public onlyOwner {
        for (uint256 i = 0; i < _addresses.length; i++) {
            tokenHolderWhitelist[_addresses[i]] = false;
        }
    }


     /**
     * mints 1 token per whitelisted address, does not charge a fee
     */
    function mintReindeerWhitelist()
        public
        returns (uint256)
    {
        require(reindeerWhitelist[msg.sender], "Not on the reindeer whitelist");
        reindeerWhitelist[msg.sender] = false;
        uint256 tokenId = mintNFT(msg.sender);
        return tokenId;
    }


    /**
     * mints 1 token per whitelisted address, does not charge a fee
     */
    function mintTokenHolderWhitelist()
        public
        returns (uint256)
    {
        require(tokenHolderWhitelist[msg.sender], "Not on the token holder whitelist");
        tokenHolderWhitelist[msg.sender] = false;
        uint256 tokenId = mintNFT(msg.sender);
        return tokenId;
    }


     /**
     * @dev public mint is a payable
     */
    function publicMint()
        public
        payable
        returns (uint256)
    {
        require(msg.value >= elfPrice, "did not provide the minimum eth");
        uint256 tokenId = mintNFT(msg.sender);
        return tokenId;
    }


    /**
     * @dev set collection URI for marketplace display
     */
    function setCollectionURI(string memory collectionURI) internal virtual onlyOwner {
        _collectionURI = collectionURI;
    }


    /**
     * @dev collection URI for marketplace display
     */
    function contractURI() public view returns (string memory) {
        return _collectionURI;
    }

    /**
     * @dev withdraw funds for elf dao to specified account
     */
    function withdraw(address payable _to) public onlyOwner {
      // get the amount of Ether stored in this contract
        uint amount = address(this).balance;
        (bool success, ) = _to.call{value: amount}("");
        require(success, "Failed to send Ether");
    }
}
