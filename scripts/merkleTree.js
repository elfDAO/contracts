const { MerkleTree } = require('merkletreejs');
const keccak256 = require('keccak256');

const elfAddresses = require('../whitelist/elf-address.json');
const reindeerAddresses = require('../whitelist/reindeer-address.json')

const elfLeafNodes = elfAddresses.map((addr) => keccak256(addr));
const elfMerkleTree = new MerkleTree(elfLeafNodes, keccak256, { sortPairs: true });
const elfRootHash = elfMerkleTree.getRoot();
console.log('elfMerkleRoot', elfRootHash.toString());

const reindeerLeafNodes = reindeerAddresses.map((addr) => keccak256(addr));
const reindeerMerkleTree = new MerkleTree(reindeerLeafNodes, keccak256, { sortPairs: true });
const reindeerRootHash = reindeerMerkleTree.getRoot();

console.log('reindeerMerkleRoot', reindeerRootHash.toString());
