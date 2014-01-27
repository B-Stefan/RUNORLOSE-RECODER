var FtpDeploy = require('ftp-deploy');
var ftpDeploy = new FtpDeploy();

var config = {
    username: "u398009041",
    password: "&e![yGEJpB5ck`>",
    host: "rol.9gb.eu",
    port: 21,
    localRoot: __dirname + "/dist",
    remoteRoot: "public_html",
    parallelUploads: 10,
    exclude: ['.git', '.idea', 'tmp/*']
}

ftpDeploy.deploy(config, function(err) {
    if (err) console.log(err)
    else console.log('finished');
});

// to be notified of what ftpDeploy is doing
ftpDeploy.on('uploading', function(data) {
    data.totalFileCount;       // total file count being transferred
    data.transferredFileCount; // number of files transferred
    data.percentComplete;      // percent as a number 1 - 100
    data.filename;             // filename being uploaded
    data.relativePath;         // relative path to file being uploaded from local root location
});
ftpDeploy.on('uploaded', function(data) {
    console.log(data);         // same data as uploading event
});