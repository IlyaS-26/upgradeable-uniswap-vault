// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

interface IVaultProxy {
    function getAdmin() external view returns (address);
    function setAdmin(address) external;
    function upgradeTo(address) external;
    function upgradeToAndCall(address, bytes calldata) external;
    function getImplimentation() external view returns (address);
}

contract AdminProxy {

    error notAnOwner();

    address private owner;

    IVaultProxy vaultProxy;

    constructor(address vaultProxyAddr) {
        owner = msg.sender;
        vaultProxy = IVaultProxy(vaultProxyAddr);
    }

    modifier onlyOwner {
        require(msg.sender == owner, notAnOwner());
        _;
    }

    function upgrade() external onlyOwner {}

    function upgradeAndCall() external onlyOwner {}

    function changeAdmin(address newAdmin) external onlyOwner {
        owner = newAdmin;
    }

    function getImplementationAddress() external view returns (address) {
        return vaultProxy.getImplimentation();
    }

    function admin() external view returns (address) {
        return vaultProxy.getAdmin();
    }
}