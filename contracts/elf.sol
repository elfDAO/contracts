//Contract based on [https://docs.openzeppelin.com/contracts/3.x/erc721](https://docs.openzeppelin.com/contracts/3.x/erc721)
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract ElfNFT is ERC721URIStorage, Ownable {
    string private _collectionURI;

    string public baseURI;
    string public baseExtension = ".json";

    // max supply of santa
    uint256 public maxSupplySanta = 5;
    uint256 public mintedSantas = 0;
    uint256 public santaId = 1; // santa are from 1-5

    // max supply of reindeer
    uint256 public maxSupplyReindeer = 500;
    uint256 public mintedReindeers = 0;
    uint256 public reindeerId = 6; // reindeer are from 6-505

    // max supply of elves
    uint256 public maxSupplyElves = 720;
    uint256 public mintedElves = 0;
    uint256 public elfId = 506; // elves are from 506-1225

    // worker elves are from 1226 onwards
    uint256 public workerElfId = 1226;

    // The whitelist of worker elves
    mapping(address => bool) public workerElfWhitelist;

    // The public mint elf price
    uint256 public elfPrice = 0.1 ether;

    // The public mint elf price
    uint256 public reindeerPrice = 0.5 ether;

    constructor(string memory _baseURI, string memory _baseExtension, string memory collectionURI) ERC721("ElfDAO NFT", "ELFDAO") {
        setCollectionURI(collectionURI);
        setBaseURI(_baseURI);
        setBaseExtension(_baseExtension);
    }

    function setPrice(uint256 _elfPrice, uint256 _reindeerPrice) public onlyOwner  {
      elfPrice = _elfPrice;
      reindeerPrice = _reindeerPrice;
    }

    function mintNFT(address recipient, uint256 tokenId) public onlyOwner
    {
        _mint(recipient, tokenId);
    }

    /**
     * @dev for worker elf whitelist
     */
    function setWorkerElfWhitelist(
        address[] memory _addresses
    ) public onlyOwner {
        for (uint256 i = 0; i < _addresses.length; i++) {
            require(
                _addresses[i] != address(0),
                "can't add the blackhole address"
            );
            workerElfWhitelist[_addresses[i]] = true;
        }
    }

    /**
     * @dev reverse accounts from worker elf whitelist
     */
    function removeWorkerElfWhitelist(address[] memory _addresses) public onlyOwner {
        for (uint256 i = 0; i < _addresses.length; i++) {
            workerElfWhitelist[_addresses[i]] = false;
        }
    }

     /**
     * mints 1 token per whitelisted address, does not charge a fee
     */
    function mintWorkerElfWhitelistWhitelist()
        public
        returns (uint256)
    {
        require(workerElfWhitelist[msg.sender], "Not on the worker elf whitelist");
        workerElfWhitelist[msg.sender] = false;
        mintNFT(msg.sender, workerElfId);
        workerElfId++;
        return workerElfId;
    }

     /**
     * @dev public elf mint is a payable
     */
    function publicElfMint()
        public
        payable
        returns (uint256)
    {
        require(msg.value >= elfPrice, "did not provide the minimum eth");
        require(mintedElves < maxSupplyElves);
        mintedElves++;
        mintNFT(msg.sender, elfId);
        elfId++;
        return elfId;
    }

         /**
     * @dev public reindeer mint is a payable
     */
    function publicReindeerMint()
        public
        payable
        returns (uint256)
    {
        require(msg.value >= reindeerPrice, "did not provide the minimum eth");
        require(mintedReindeers < maxSupplyReindeer);
        mintedReindeers++;
        mintNFT(msg.sender, reindeerId);
        reindeerId++;
        return reindeerId;
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
