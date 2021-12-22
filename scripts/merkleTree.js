const { MerkleTree } = require('merkletreejs');
const keccak256 = require('keccak256');

const generateElfRoot = () => {
  const elfAddresses = require('../whitelist/elfWhitelist.json');
  const elfLeafNodes = elfAddresses.map((addr) => keccak256(addr));
  const elfMerkleTree = new MerkleTree(elfLeafNodes, keccak256, { sortPairs: true });
  const elfRootHash = elfMerkleTree.getHexRoot();
  console.log('elfRootHash', elfRootHash.toString('hex'));
  return elfRootHash;
}

const generateReindeerRoot = () => {
  const reindeerAddresses = require('../whitelist/reindeerWhitelist.json');
  const reindeerLeafNodes = reindeerAddresses.map((addr) => keccak256(addr));
  const reindeerMerkleTree = new MerkleTree(reindeerLeafNodes, keccak256, { sortPairs: true });
  const reindeerRootHash = reindeerMerkleTree.getHexRoot();

  console.log('reindeerRootHash', reindeerRootHash);
  return reindeerRootHash;
};

const generateWorkerElfRoot = () => {
  const workerElfAddresses = require('../whitelist/workerElfWhitelist.json')
  const workerElfLeafNodes = workerElfAddresses.map((addr) => keccak256(addr));
  const workerElfMerkleTree = new MerkleTree(workerElfLeafNodes, keccak256, { sortPairs: true });
  const workerElfRootHash = workerElfMerkleTree.getHexRoot();

  console.log('workerElfRootHash', workerElfRootHash);
  return workerElfRootHash;
};

const generateSantaRoot = () => {
  const santaAddresses = require('../whitelist/santaWhitelist.json')
  const santaLeafNodes = santaAddresses.map((addr) => keccak256(addr));
  const santaMerkleTree = new MerkleTree(santaLeafNodes, keccak256, { sortPairs: true });
  const santaRootHash = santaMerkleTree.getHexRoot();

  console.log('santaRootHash', santaRootHash);
  return santaRootHash;
};

module.exports = { generateElfRoot, generateReindeerRoot, generateSantaRoot, generateWorkerElfRoot };

generateElfRoot()
generateReindeerRoot()