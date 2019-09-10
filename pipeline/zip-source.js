const fs = require('fs');
const archiver = require('archiver');

function zipSource() {
  return new Promise((resolve, reject) => {
    const outputStream = fs.createWriteStream('./pipeline/lambda.zip');
    // listen for all archive data to be written
    outputStream.on('close', () => {
      resolve();
    });

    const archive = archiver('zip', {
      zlib: { level: 9 }
    });
    // good practice to catch this error explicitly
    archive.on('error', (err) => {
      reject(err);
    });

    archive.pipe(outputStream);
    archive.directory('dist', '/');
    archive.directory('node_modules', '/node_modules');
    archive.finalize();
  });
}

zipSource();
