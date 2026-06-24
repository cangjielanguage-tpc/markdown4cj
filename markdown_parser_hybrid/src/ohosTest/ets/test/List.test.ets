import aTest from './a.test';
import bTest from './b.test';
import bugTest from './bug.test';
import abilityTest from './Ability.test';

export default function testsuite() {
  abilityTest();
  aTest()
  bTest()
  bugTest()
}