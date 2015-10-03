var fs = require('fs-extra');
var path = require('path');

exports.hook = function(flow, done){
  // generic json reading function
  function read_json (file_path) {
      var temp;
      //console.log(path.resolve(file_path))
      temp = fs.readFileSync(path.resolve(file_path));
      return JSON.parse(temp);
  };

  //read our config file
  var config_file = "./hooks/config.json";

  var config = read_json(config_file)
  var dirs = config.dirs

  console.log("copy-to-gh-pages - Source dir: "+ dirs.bin+", Target dir: "+ dirs.gh_pages)
  fs.copy(dirs.bin,dirs.gh_pages, function copy_site(err){
  	if (err) throw err //failed copy
  	console.log("copy-to-gh-pages - Project copied")
    console.log("copy-to-gh-pages - Copying git_files...")
    fs.readdir(dirs.git_files,function copy_git_files(err,files){
      if (err) throw err
      for (var i = 0; i<files.length;i++) {
        var file = files[i]
        console.log("copy-to-gh-pages -  Copied "+file)
        fs.copy(path.join(dirs.git_files,file),path.join(dirs.gh_pages,file), function copy_file(err){
      		if (err) throw err
      	})
      } // for
      done()

    })  // readdir
  })   // copy
}
