const { MerkleTree } = require('merkletreejs');
const keccak256 = require('keccak256');

const elfAddress = require('../whitelist/elf-address.json');
const reindeerAddress = require('../whitelist/reindeer-address.json')

const elfLeafNodes = elfAddress.map((addr) => keccak256(addr));
const elfMerkleTree = new MerkleTree(elfLeafNodes, keccak256, { sortPairs: true });

const elfRootHash = elfMerkleTree.getRoot();
console.log('merkleRoot', elfRootHash.toString());
