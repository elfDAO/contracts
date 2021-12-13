//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract ElfNFT is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    string private _collectionURI;

    string public baseURI;
    string public baseExtension = ".json";

    // max supply of santa
    uint256 public maxSupplySanta = 5;
    uint256 public mintedSantas = 0;

    // max supply of reindeer
    uint256 public maxSupplyReindeer = 750;
    uint256 public mintedReindeers = 0;

    // max supply of elves
    uint256 public maxSupplyElves = 4000;
    uint256 public mintedElves = 0;

    // The whitelist of reindeers
    mapping(address => bool) public reindeerWhitelist;

    // The whitelist for santa (top contributors)
    mapping(address => bool) public santaWhitelist;

    // The public mint elf price
    uint256 public elfPrice = 0.05 ether; // TODO: decide on price

    // The public mint elf price
    uint256 public reindeerPrice = 0.1 ether; // TODO: decide on price

    constructor(string memory _baseURI, string memory _baseExtension, string memory collectionURI) ERC721("ElfDAO NFT", "ELFDAO") {
        setCollectionURI(collectionURI);
        setBaseURI(_baseURI);
        setBaseExtension(_baseExtension);
    }

    function setPrice(uint256 _elfPrice, uint256 _reindeerPrice) public onlyOwner  {
      elfPrice = _elfPrice;
      reindeerPrice = _reindeerPrice;
    }

    function mintNFT(address recipient) public onlyOwner returns (uint256)
    {
        _tokenIds.increment();
        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);
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
     * @dev reverse accounts from reindeer whitelist
     */
    function removeReindeerWhitelists(address[] memory _addresses) public onlyOwner {
        for (uint256 i = 0; i < _addresses.length; i++) {
            reindeerWhitelist[_addresses[i]] = false;
        }
    }


    /**
     * @dev for top 5 contributors
     */
    function setSantaWhitelist(
        address[] memory _addresses
    ) public onlyOwner {
        require(_addresses.length <= 5); // maxSupply is 5
        for (uint256 i = 0; i < _addresses.length; i++) {
            require(
                _addresses[i] != address(0),
                "can't add the blackhole address"
            );
            santaWhitelist[_addresses[i]] = true;
        }
    }


    /**
     * @dev remove users from Santa whitelist
     */
    function removeSantaWhitelists(address[] memory _addresses) public onlyOwner {
        for (uint256 i = 0; i < _addresses.length; i++) {
            santaWhitelist[_addresses[i]] = false;
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
        require(mintedReindeers < maxSupplyReindeer);
        mintedReindeers++;
        reindeerWhitelist[msg.sender] = false;
        uint256 tokenId = mintNFT(msg.sender);
        return tokenId;
    }


    /**
     * mints 1 token per whitelisted address, does not charge a fee
     */
    function mintSantaWhitelist()
        public
        returns (uint256)
    {
        require(santaWhitelist[msg.sender], "Not on the token holder whitelist");
        require(mintedSantas < maxSupplySanta); // should never fail
        mintedSantas++;
        santaWhitelist[msg.sender] = false;
        uint256 tokenId = mintNFT(msg.sender);
        return tokenId;
    }


     /**
     * @dev public elf mint is a payable
     */
    function publicElfMint()
        public
        payable
        returns (uint256)
    {
        // TODO: decide if batch mint or donation based values
        require(msg.value >= elfPrice, "did not provide the minimum eth");
        require(mintedElves < maxSupplyElves);
        mintedElves++;
        uint256 tokenId = mintNFT(msg.sender);
        return tokenId;
    }

         /**
     * @dev public reindeer mint is a payable
     */
    function publicReindeerMint()
        public
        payable
        returns (uint256)
    {
        require(msg.value >= elfPrice, "did not provide the minimum eth");
        require(mintedReindeers < maxSupplyReindeer);
        mintedReindeers++;
        uint256 tokenId = mintNFT(msg.sender);
        return tokenId;
    }

    function tokenURI(uint256 tokenId)
    public
    view
    virtual
    override
    returns (string memory)
    {
      require(_exists(tokenId), "ERC721Metadata: query for nonexistent token");

      return string(abi.encodePacked(baseURI, Strings.toString(tokenId), baseExtension));
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

    function setBaseURI(string memory _baseURI) public onlyOwner {
      require(bytes(_baseURI).length > 0);
      baseURI = _baseURI;
    }

    function setBaseExtension(string memory _baseExtension) public onlyOwner {
      baseExtension = _baseExtension;
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
