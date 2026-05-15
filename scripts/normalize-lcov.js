'use strict';

// Normalises coverage/lcov.info paths so SonarQube can resolve them.
//
// Some nyc/istanbul builds emit `SF:./path/to/file.js` with a leading `./`.
// SonarQube's LCOV importer does NOT strip that prefix and silently fails
// to match it against the indexed files, which is one of the typical
// reasons the Coverage column shows "Not computed".

var fs = require('fs');
var path = require('path');

var lcovPath = path.resolve(__dirname, '..', 'coverage', 'lcov.info');

if (!fs.existsSync(lcovPath)) {
	console.error('normalize-lcov: ' + lcovPath + ' not found; nothing to normalize.');
	process.exit(0);
}

var original = fs.readFileSync(lcovPath, 'utf8');
var normalized = original.replace(/^SF:\.\//gm, 'SF:');

if (normalized === original) {
	console.log('normalize-lcov: no SF:./ entries, nothing to change.');
	process.exit(0);
}

fs.writeFileSync(lcovPath, normalized);
console.log('normalize-lcov: stripped leading "./" from SF entries in ' + lcovPath + '.');
