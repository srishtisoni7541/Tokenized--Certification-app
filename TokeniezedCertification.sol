// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TokenizedCertification is ERC721URIStorage, Ownable {
    uint256 public nextTokenId;
    mapping(address => bool) public certifiedStudents;

    // Pass the initial owner address to the Ownable constructor
    constructor(address initialOwner) ERC721("CertificationToken", "CERT") Ownable(initialOwner) {}

    // Function to issue certification as an NFT
    function issueCertification(address student, string memory tokenURI) public onlyOwner {
        require(!certifiedStudents[student], "Student already certified");

        uint256 tokenId = nextTokenId;
        nextTokenId++;

        certifiedStudents[student] = true;

        _mint(student, tokenId);
        _setTokenURI(tokenId, tokenURI); // Sets metadata URI for the NFT
    }

    // Check if a student is certified
    function isCertified(address student) public view returns (bool) {
        return certifiedStudents[student];
    }
}
