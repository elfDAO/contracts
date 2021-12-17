const { MerkleTree } = require('merkletreejs');
const keccak256 = require('keccak256');

const generateElfRoot = () => {
  const elfAddresses = require('../whitelist/elfAddress.json');
  const elfLeafNodes = elfAddresses.map((addr) => keccak256(addr));
  const elfMerkleTree = new MerkleTree(elfLeafNodes, keccak256, { sortPairs: true });
  const elfRootHash = elfMerkleTree.getRoot();
  console.log('elfRootHash', elfRootHash.toString('hex'));
  return elfRootHash;
}

const generateReindeerRoot = () => {
  const reindeerAddresses = require('../whitelist/reindeerAddress.json');
  const reindeerLeafNodes = reindeerAddresses.map((addr) => keccak256(addr));
  const reindeerMerkleTree = new MerkleTree(reindeerLeafNodes, keccak256, { sortPairs: true });
  const reindeerRootHash = reindeerMerkleTree.getRoot();

  console.log('reindeerRootHash', reindeerRootHash.toString('hex'));
  return reindeerRootHash;
};

const generateWorkerElfRoot = () => {
  const workerElfAddresses = require('../whitelist/workerElfAddress.json')
  const workerElfLeafNodes = workerElfAddresses.map((addr) => keccak256(addr));
  const workerElfMerkleTree = new MerkleTree(workerElfLeafNodes, keccak256, { sortPairs: true });
  const workerElfRootHash = workerElfMerkleTree.getRoot();

  console.log('workerElfRootHash', workerElfRootHash.toString('hex'));
  return workerElfRootHashl;
};

const generateSantaRoot = () => {
  const santaAddresses = require('../whitelist/santaAddress.json')
  const santaLeafNodes = santaAddresses.map((addr) => keccak256(addr));
  const santaMerkleTree = new MerkleTree(santaLeafNodes, keccak256, { sortPairs: true });
  const santaRootHash = santaMerkleTree.getRoot();

  console.log('santaRootHash', santaRootHash.toString('hex'));
  return santaRootHash;
};

module.exports = { generateElfRoot, generateReindeerRoot, generateSantaRoot, generateWorkerElfRoot };