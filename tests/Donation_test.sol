// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.4.22 <0.9.0;

// This import is automatically injected by Remix
import "remix_tests.sol"; 
// This import is required to use custom transaction context
// Although it may fail compilation in 'Solidity Compiler' plugin
// But it will work fine in 'Solidity Unit Testing' plugin
import "remix_accounts.sol";
import "../contracts/Donation.sol";

// File name has to end with '_test.sol', this file can contain more than one testSuite contracts
contract testSuite {
    Donation public donation;
    address acc0 = TestsAccounts.getAccount(0); //owner by default
    address acc1 = TestsAccounts.getAccount(1);
    address acc2 = TestsAccounts.getAccount(2);
    address acc3 = TestsAccounts.getAccount(3);
    address recipient = TestsAccounts.getAccount(4); //recipient
    /// 'beforeAll' runs before all other tests
    /// More special functions are: 'beforeEach', 'beforeAll', 'afterEach' & 'afterAll'
    function beforeAll() public {
        // <instantiate contract>
        donation = new Donation();
    }
    function checkInitialAmount() public {
        donation.getSumOfDonations();
        Assert.equal(donation.getSumOfDonations(),0,"Should be zero initialy");
    }

    /// #value: 202
    /// #sender: account-1
    function donateAcc1AndCheckBalance() public payable{
        Assert.equal(msg.value, 202, 'value should be 202 wei');
        donation.donate();
        Assert.equal(donation.getSumOfDonations(),202, "Should be equal");
    }
}
    