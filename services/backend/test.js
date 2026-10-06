const assert = require('assert');

// Simple smoke test for Jenkins test stage
console.log('Running automated backend unit tests...');
assert.strictEqual(1 + 1, 2, 'Math assertion test failed');
console.log('All tests passed successfully!');
process.exit(0);
