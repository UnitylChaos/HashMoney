

const HM = artifacts.require("HashMoney");

contract("HM", async (accounts) =>  {
  let hm;
  beforeEach(async () => {
    hm = await HM.new();
  })
  it("should check leading zeros correctly", async () => {
    assert.equal(await hm.countLeadingZeroes.call("0xffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"), 0);
    assert.equal(await hm.countLeadingZeroes.call("0x7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"), 1);
    assert.equal(await hm.countLeadingZeroes.call("0x3fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"), 2);
    assert.equal(await hm.countLeadingZeroes.call("0x1fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"), 3);
    assert.equal(await hm.countLeadingZeroes.call("0x0fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"), 4);
    assert.equal(await hm.countLeadingZeroes.call("0x00ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"), 8);
    assert.equal(await hm.countLeadingZeroes.call("0x001fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"), 11);
    assert.equal(await hm.countLeadingZeroes.call("0x0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff"), 16);
    assert.equal(await hm.countLeadingZeroes.call("0x0000000000000000000000000000000000000000000000000000000000000001"), 255);
  });
})
